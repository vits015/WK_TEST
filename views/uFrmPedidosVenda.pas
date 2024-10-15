unit uFrmPedidosVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls, uClienteController, uCliente,System.Generics.Collections,
  uProduto, uProdutoController, uProdutoPedidoController, uPedidoController, Vcl.DBGrids,
  Vcl.Imaging.pngimage, ShellAPI, Vcl.Mask;


type
  TFormState = (csInsert, csEdit);

type
  TfrmPedidosVenda = class(TForm)
    cbClientes: TComboBox;
    lbClientes: TLabel;
    pnProduto: TPanel;
    edCodigoProduto: TEdit;
    lbCodProduto: TLabel;
    edQtdProduto: TEdit;
    lbQtdProduto: TLabel;
    edValorUnitarioProduto: TEdit;
    lbValorUnitarioProduto: TLabel;
    lbProduto: TLabel;
    btnAddProduto: TButton;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    dbgProdutos: TDBGrid;
    lbDescricaoProduto: TLabel;
    edDescricaoProduto: TEdit;
    pnRodape: TPanel;
    lbValorTotalPedido: TLabel;
    Panel1: TPanel;
    lbValorTotal: TLabel;
    btnSalvarPedido: TButton;
    btnCarregarPedido: TButton;
    pnCarregarPedido: TPanel;
    edNumPedido: TEdit;
    lbNumPedidoEdit: TLabel;
    btnLimparCliente: TButton;
    btnCancelarPedido: TButton;
    pnCliente: TPanel;
    imgLogo: TImage;
    procedure FormCreate(Sender: TObject);
    procedure edCodigoProdutoExit(Sender: TObject);
    procedure btnAddProdutoClick(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSalvarPedidoClick(Sender: TObject);
    procedure cbClientesSelect(Sender: TObject);
    procedure btnLimparClienteClick(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure edCodigoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edQtdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edValorUnitarioProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edNumPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FConnection: TFDConnection;
    FCurrentState: TFormState;
    procedure SetCurrentState(Value: TFormState);
    procedure CreateControllers;
    procedure DestroyControllers;
    procedure ConfigurarConexao;
    procedure CarregaClientesCombobox;
    procedure CarregaProduto(ACodigo:Integer);
    procedure RemoveProdutoGrid(ACodigo: Integer);
    procedure AdicionaProdutoGrid( AProduto: TProduto; AQuantidade: Integer);
    procedure AtualizaProdutoGrid( AProduto: TProduto; AQuantidade: Integer);
    procedure ExibeProdutosGrid;
    procedure AtualizaValorTotalPedido;
    procedure ToggleExibitionPnCarregarPedidos;
    function SalvarPedido: boolean;
    procedure LimpaGrid;
    procedure CarregaPedido;
    function DeletePedido(ANumeroPedido:Integer):boolean;
    function SomenteNumero(key:Char):Char;
    function ValidaQtdProduto:boolean;
    function ValidaCodigoProduto:boolean;
    function ValidaClientePedido:boolean;
    function ValidaNumeroPedido:boolean;
    procedure CriaTabelaTemporaria;
    procedure VisualizaInfoProduto;
    procedure deletaProdutoGrid;
    procedure editaProdutoGrid;
    procedure LimpaProduto;
  public
    { Public declarations }
    property CurrentState: TFormState read FCurrentState write SetCurrentState; // Propriedade de estado
    procedure UpdateForm;
  end;

var
  frmPedidosVenda: TfrmPedidosVenda;
  Query : TFDQuery;
  clienteController: TClienteController;
  produtoController: TProdutoController;
  produtopedidoController : TProdutopedidoController;
  pedidoController : TPedidoController ;


implementation

{$R *.dfm}

uses uProdutoPedido, uPedido;

{ TForm1 }

procedure TfrmPedidosVenda.AdicionaProdutoGrid(AProduto: TProduto ; AQuantidade: integer);
begin
    Query.SQL.Clear;
    Query.SQL.Text := 'INSERT INTO tmp_Produtos (Codigo, Descricao, Preco_Venda, Quantidade) '
                     +'VALUES (:codigo,:descricao,:preco_venda, :Quantidade);' ;

    Query.ParamByName('codigo').Value := AProduto.Codigo;
    Query.ParamByName('descricao').Value := AProduto.Descricao;
    Query.ParamByName('preco_venda').Value := AProduto.PrecoVenda;
    Query.ParamByName('Quantidade').Value := AQuantidade;

    Query.ExecSQL;

end;

procedure TfrmPedidosVenda.AtualizaProdutoGrid(AProduto: TProduto;
  AQuantidade: Integer);
begin
    Query.SQL.Clear;
    Query.Close;
    Query.SQL.Text:= 'UPDATE tmp_Produtos set preco_venda = :preco_venda, Quantidade = :Quantidade WHERE codigo = :codigo';

    Query.ParamByName('preco_venda').Value := AProduto.PrecoVenda;
    Query.ParamByName('Quantidade').Value := AQuantidade;
    Query.ParamByName('codigo').Value := AProduto.Codigo;

    Query.ExecSQL;
    SetCurrentState(csInsert);
end;

procedure TfrmPedidosVenda.AtualizaValorTotalPedido;
begin
  Query.Sql.Clear;
  Query.Close;

  Query.SQL.Text := 'SELECT REPLACE(FORMAT(SUM((preco_venda*Quantidade)),2),'+QuotedStr('.')+','+quotedStr(',')+') Total_Pedido from tmp_Produtos';
  Query.Open;

  lbValorTotalPedido.Caption := 'R$ '+Query.FieldByName('Total_Pedido').AsString;

end;

procedure TfrmPedidosVenda.btnAddProdutoClick(Sender: TObject);
var
  produto: TProduto;
  quantidade: Integer;
begin
  if not ValidaQtdProduto then
    exit;
  if not ValidaCodigoProduto then
    exit;

  Quantidade:= StrToInt(edQtdProduto.Text);
  produto := TProduto.Create(
                            StrToInt(edCodigoProduto.Text),
                            edDescricaoProduto.Text,
                            StrToFloat(edValorUnitarioProduto.Text) );

  if FCurrentState = csInsert then
  begin
    AdicionaProdutoGrid(produto, quantidade);
  end else
  if FCurrentState = csEdit then
  begin
   AtualizaProdutoGrid(produto,quantidade);
  end;
  LimpaProduto;
  ExibeProdutosGrid;
end;

procedure TfrmPedidosVenda.btnCancelarPedidoClick(Sender: TObject);
begin
  try
    if not ValidaNumeroPedido then
      exit;

    if (DeletePedido(StrToInt(edNumPedido.Text)) ) then
      Application.MessageBox('Pedido Excluído com sucesso!','Sucesso');
  except
    on e:exception do
    begin
      Application.MessageBox(Pchar(e.Message),'Erro',MB_ICONERROR);
    end;
  end;

  ExibeProdutosGrid;
end;

procedure TfrmPedidosVenda.btnCarregarPedidoClick(Sender: TObject);
begin
  try
    CarregaPedido;
  except
    on e:exception do
    begin
      Application.MessageBox(PChar(e.Message),'Erro',MB_ICONERROR);
    end;

  end;
end;

procedure TfrmPedidosVenda.btnLimparClienteClick(Sender: TObject);
begin
  cbClientes.ItemIndex := -1;
  ToggleExibitionPnCarregarPedidos;
end;

procedure TfrmPedidosVenda.btnSalvarPedidoClick(Sender: TObject);
var
  ultimoPedido:integer;
begin
  try
    if not ValidaClientePedido then
      exit;
    if (SalvarPedido) then
    begin
      ultimoPedido:= pedidoController.getLastPedidoNumber;
      Application.MessageBox(Pchar('Pedido '+UltimoPedido.ToString()+' Gravado com sucesso!'),'Sucesso');
      LimpaGrid;
      ExibeProdutosGrid;
    end;
  except
    on E:Exception do
    begin
      Application.MessageBox(Pchar(e.Message),'Erro', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmPedidosVenda.CarregaClientesCombobox;
var
   Clientes: TObjectList<TCliente>;
   Cliente: TCliente;
begin
  try
    Clientes:= clienteController.getClientes;
    cbClientes.Clear;

    for cliente in Clientes do
    begin
      cbClientes.Items.AddObject(cliente.Nome, TObject(cliente));
    end;
  finally
    Clientes.Free;
  end;
end;

procedure TfrmPedidosVenda.CarregaPedido;
var
  i:integer;
begin
  try
    dbgProdutos.DataSource:= pedidoController.getPedido(StrToInt(edNumPedido.Text));

    (dbgProdutos.DataSource.DataSet.FieldByName('valor_total_pedido') as TBCDField).DisplayFormat := 'R$ ###,##0.00';
    (dbgProdutos.DataSource.DataSet.FieldByName('valor_unitario') as TBCDField).DisplayFormat := 'R$ ###,##0.00';
    (dbgProdutos.DataSource.DataSet.FieldByName('valor_total_produto') as TBCDField).DisplayFormat := 'R$ ###,##0.00';

    dbgProdutos.Columns[0].Title.Caption := 'Número do Pedido';
    dbgProdutos.Columns[1].Title.Caption := 'Data de emissão';
    dbgProdutos.Columns[2].Title.Caption := 'Código do Cliente';
    dbgProdutos.Columns[3].Title.Caption := 'Valor total do Pedido';
    dbgProdutos.Columns[4].Title.Caption := 'Código do produto';
    dbgProdutos.Columns[5].Title.Caption := 'Quantidade';
    dbgProdutos.Columns[6].Title.Caption := 'Valor Unitário';
    dbgProdutos.Columns[7].Title.Caption := 'Valor Total do Produto';

    for i := 0 to dbgProdutos.Columns.Count - 1 do
    begin
      dbgProdutos.Columns[i].Title.Font.Style := [fsBold];
    end;

    lbValorTotalPedido.Caption:= dbgProdutos.Fields[3].Text;
    cbClientes.ItemIndex := StrToInt(dbgProdutos.Fields[2].Text);
  except
    on E:Exception do
    begin
      raise Exception.CreateFmt('Pedido não encontrado. ', [E.Message]);
    end;

  end;
end;

procedure TfrmPedidosVenda.CarregaProduto(ACodigo: Integer);
var
  produto:TProduto;
begin
  try
    produto := produtoController.getProdutos(ACodigo).First;
    edValorUnitarioProduto.Text := produto.PrecoVenda.ToString();
    edDescricaoProduto.Text := produto.Descricao;
  except
    on e:exception do
    begin
      raise Exception.CreateFmt(e.Message,[e.Message]);
    end;

  end;
end;

procedure TfrmPedidosVenda.cbClientesSelect(Sender: TObject);
begin
  ToggleExibitionPnCarregarPedidos;
end;

procedure TfrmPedidosVenda.ConfigurarConexao;
begin
  FConnection := TFDConnection.Create(nil);
  FConnection.Connected := False;  // Desconectar caso esteja conectado
  FConnection.Params.Clear;
  FConnection.Params.LoadFromFile('config.ini');  // Carregar parâmetros do .ini
  try
    FConnection.Connected := True;
  except
    on E: Exception do
      ShowMessage('Erro na conexão: ' + E.Message);
  end;
end;

procedure TfrmPedidosVenda.CreateControllers;
begin
  produtopedidoController:= TProdutoPedidoController.Create(FConnection);
  pedidoController := TPedidoController.Create(FConnection);
  clienteController := TClienteController.Create(FConnection);
  produtoController := TProdutoController.Create(FConnection);
end;

procedure TfrmPedidosVenda.CriaTabelaTemporaria;
begin
  Query.close;
  Query.SQL.Clear;

  Query.SQL.Text := 'CREATE TEMPORARY TABLE IF NOT EXISTS tmp_Produtos ( '
                   + 'Codigo int, '
                   + 'Descricao varchar(50),'
                   + 'Preco_Venda decimal(15,2),'
                   + 'Quantidade int );';
    Query.ExecSQL;
end;

procedure TfrmPedidosVenda.dbgProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Query : TFDQuery;
begin
  VisualizaInfoProduto;

  if(key = VK_RETURN) then
  begin
    editaProdutoGrid;
  end else
  if (key = VK_DELETE) then
  begin
    deletaProdutoGrid;
    ExibeProdutosGrid;
  end;
end;

procedure TfrmPedidosVenda.deletaProdutoGrid;
begin
  if FCurrentState = csEdit then
  begin
    Application.MessageBox('Não é possível deletar um produto enquanto estiver em modo de edição!','Atenção',MB_ICONEXCLAMATION);
    exit;
  end;
  if (dbgProdutos.FieldCount <8) and (FCurrentState <> csEdit) then
  begin
    if ValidaCodigoProduto then
      begin
      if (MessageBox(Handle,PChar('Tem certeza que quer excluir o item de codigo: ' + edCodigoProduto.Text + ' ?'),
      'Confirmação de Exclusão', MB_YESNO+MB_ICONQUESTION ) = mrYes) then
      begin
        RemoveProdutoGrid(strToInt(edCodigoProduto.Text));
      end;
    end;
  end;
end;

function TfrmPedidosVenda.DeletePedido(ANumeroPedido:Integer) : boolean;
begin
  try
    pedidoController.DeletePedido(ANumeroPedido);
    result:= true;
  except
    on e:exception do
    begin
      Result := false;
      Application.MessageBox(Pchar(e.Message),'Erro',MB_ICONERROR);
    end;
  end;
end;

procedure TfrmPedidosVenda.DestroyControllers;
begin
  pedidoController.Free;
  produtopedidoController.Free;
  clienteController.Free;
  produtoController.Free;
end;

procedure TfrmPedidosVenda.edCodigoProdutoExit(Sender: TObject);
begin
  if edCoDigoProduto.Text<>'' then
    CarregaProduto(StrToInt(edCodigoProduto.Text));
end;

procedure TfrmPedidosVenda.edCodigoProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:= SomenteNumero(Key);
end;

procedure TfrmPedidosVenda.editaProdutoGrid;
begin
  if (dbgProdutos.FieldCount <8) and (dbgProdutos.DataSource <> nil) and
  (dbgProdutos.DataSource.DataSet.RecordCount > 0) then
    SetCurrentState(csEdit);
end;

procedure TfrmPedidosVenda.edNumPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  key:= SomenteNumero(Key);
end;

procedure TfrmPedidosVenda.edQtdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  key:= SomenteNumero(Key);
end;

procedure TfrmPedidosVenda.edValorUnitarioProdutoKeyPress(Sender: TObject;
  var Key: Char);
var
  DecimalSeparator:Char;
begin
  DecimalSeparator := ',';
  if (Key = DecimalSeparator) and (Pos(DecimalSeparator, TEdit(Sender).Text) > 0) then
    Key := #0  // Impede a entrada de mais de um separador decimal
  else if not (Key in ['0'..'9', DecimalSeparator, #8]) then
    Key := #0;  // Impede a entrada de qualquer caractere não numérico ou decimal
end;

procedure TfrmPedidosVenda.ExibeProdutosGrid;
var
  Query : TFDQuery;
  ds :TDataSource;
  i:integer;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConnection;
  ds:= TDataSource.Create(nil);
  ds.DataSet:= Query;

  Query.SQL.Text := 'SELECT Codigo, Descricao, preco_venda as Valor_unitario, Quantidade, (preco_venda*Quantidade) as Valor_Total FROM tmp_Produtos';
  Query.Open;

  dbgProdutos.DataSource:= ds;
  (ds.DataSet.FieldByName('Valor_unitario') as TBCDField).DisplayFormat := 'R$ ###,##0.00';
  (ds.DataSet.FieldByName('Valor_Total') as TFMTBCDField).DisplayFormat := 'R$ ###,##0.00';

  dbgProdutos.Columns[0].Title.Caption := 'Código';
  dbgProdutos.Columns[1].Title.Caption := 'Descrição';
  dbgProdutos.Columns[2].Title.Caption := 'Valor Unitário';
  dbgProdutos.Columns[3].Title.Caption := 'Quantidade';
  dbgProdutos.Columns[4].Title.Caption := 'Valor Total';
  for i := 0 to dbgProdutos.Columns.Count - 1 do
  begin
    dbgProdutos.Columns[i].Title.Font.Style := [fsBold];
  end;

  AtualizaValorTotalPedido;
end;

procedure TfrmPedidosVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Showmessage('Desde já agradeço pela oportunidade!');
  Showmessage('Conheça um pouco mais sobre mim a seguir!');
  ShellExecute(0, 'open', 'http://sitevits015.vercel.app', nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TfrmPedidosVenda.FormCreate(Sender: TObject);
begin
  ConfigurarConexao;
  Query := TFDQuery.Create(nil);
  Query.Connection := FConnection;
  CriaTabelaTemporaria;
  CreateControllers;
  CarregaClientesCombobox;
end;

procedure TfrmPedidosVenda.LimpaGrid;
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Text := 'DELETE FROM tmp_produtos';
  Query.ExecSQL;
end;

procedure TfrmPedidosVenda.LimpaProduto;
begin
  edCodigoProduto.Text        := EmptyStr;
  edDescricaoProduto.Text     := EmptyStr;
  edQtdProduto.Text           := EmptyStr;
  edValorUnitarioProduto.Text := EmptyStr;
  edCodigoProduto.SetFocus;
end;

procedure TfrmPedidosVenda.RemoveProdutoGrid(ACodigo: Integer);
var
  Query:TFDQuery;
begin
  Query:= TFDQuery.Create(nil);
  Query.Connection := FConnection;

  Query.SQL.Text:= 'DELETE FROM tmp_produtos WHERE codigo = :codigo';
  Query.ParamByName('codigo').Value := ACodigo;
  Query.ExecSQL;

end;

function TfrmPedidosVenda.SalvarPedido : boolean;
var
  Pedido: TPedido;
begin
  Query.Close;
  Query.SQL.Clear;

  try
    Pedido := TPedido.Create(0,
                            now(),
                            cbClientes.ItemIndex+1,
                            StrToFloat(StringReplace(lbValorTotalPedido.Caption,'R$ ','',[rfReplaceAll])));

    Query.SQL.Text := 'SELECT Codigo, Descricao, preco_venda as Valor_unitario, Quantidade, (preco_venda*Quantidade) as Valor_Total FROM tmp_Produtos';
    Query.Open;

    if Query.RecordCount < 1 then
      raise Exception.Create('Para cadastrar um pedido é necessário incluir pelo menos um produto!');

    while not Query.eof do
    begin
      Pedido.AdicionarProduto(TProdutoPedido.Create(0,
                              Query.FieldByName('Codigo').AsInteger,
                              Query.FieldByName('Quantidade').AsInteger,
                              Query.FieldByName('Valor_unitario').AsFloat) );
      Query.Next;
    end;
    pedidoController.PostPedido(Pedido);
    result:= true;
  except
    on E:Exception do
    begin
      raise Exception.CreateFmt('É necessário inserir pelo menos um produto para salvar o pedido!',[E.Message]);
      result := false;
    end;
  end;

end;

procedure TfrmPedidosVenda.SetCurrentState(Value: TFormState);
begin
  FCurrentState := Value;
  UpdateForm;
end;

function TfrmPedidosVenda.SomenteNumero(key:Char):Char;
begin
  if not (Key in ['0'..'9',#8]) then
  begin
    Result := #0;
  end else
  begin
    Result:= Key;
  end;
end;

procedure TfrmPedidosVenda.ToggleExibitionPnCarregarPedidos;
begin
  if cbClientes.ItemIndex < 0 then
    pnCarregarPedido.Visible := true
  else
    pnCarregarPedido.Visible := false;
end;

procedure TfrmPedidosVenda.UpdateForm;
begin
  if FCurrentState = csInsert then
  begin
    btnAddProduto.Caption := 'Inserir Produto';
    edCodigoProduto.Enabled:= true;
    btnSalvarPedido.Enabled:= true;
  end else
  if FCurrentState = csEdit then
  begin
    edCodigoProduto.Enabled:= false;
    btnSalvarPedido.Enabled:= false;
    edValorUnitarioProduto.SetFocus;
    btnAddProduto.Caption := 'Alterar Produto';
  end;

  Application.ProcessMessages;

end;

function TfrmPedidosVenda.ValidaClientePedido: boolean;
begin
    if cbClientes.ItemIndex < 0 then
    begin
      Application.MessageBox('O campo cliente é obrigatório!','Atenção',MB_ICONEXCLAMATION);
      cbClientes.SetFocus;
      Result:= false;
    end else
    begin
      Result:= true;
    end;
end;

function TfrmPedidosVenda.ValidaCodigoProduto: boolean;
begin
  if edCodigoProduto.Text='' then
  begin
    Application.MessageBox('Informe o código do produto !','Atenção',MB_ICONEXCLAMATION);
    edCodigoProduto.SetFocus;
    Result:= false;
  end else
  begin
    Result:= true;
  end;
end;

function TfrmPedidosVenda.ValidaNumeroPedido: boolean;
begin
  if edNumPedido.Text='' then
  begin
    Application.MessageBox('Informe o numero do pedido !','Atenção',MB_ICONEXCLAMATION);
    edNumPedido.SetFocus;
    Result:= false;
  end else
  begin
    Result:= true;
  end;
end;

function TfrmPedidosVenda.ValidaQtdProduto: boolean;
begin
  if edQtdProduto.Text='' then
  begin
    Application.MessageBox('Informe a quantidade do produto !','Atenção',MB_ICONEXCLAMATION);
    edQtdProduto.SetFocus;
    Result:= false;
  end else
  begin
    Result:= true;
  end;
end;

procedure TfrmPedidosVenda.VisualizaInfoProduto;
begin
  try
    edCodigoProduto.Text:= dbgProdutos.DataSource.dataset.fieldbyname('codigo').AsString;
    edDescricaoProduto.Text:= dbgProdutos.DataSource.dataset.fieldbyname('Descricao').AsString;
    edValorUnitarioProduto.Text:= dbgProdutos.DataSource.dataset.fieldbyname('Valor_Unitario').AsString;
    edQtdProduto.Text:= dbgProdutos.DataSource.dataset.fieldbyname('Quantidade').AsString;
  except
  end;
end;

end.
