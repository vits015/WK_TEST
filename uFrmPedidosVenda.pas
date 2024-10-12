unit uFrmPedidosVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls;

type
  TfrmPedidosVenda = class(TForm)
    Conexao: TFDConnection;
    DriverMySQL: TFDPhysMySQLDriverLink;
    ComboBox1: TComboBox;
    lbClientes: TLabel;
    pnProduto: TPanel;
    edCodigoProduto: TEdit;
    lbCodProduto: TLabel;
    edQtdProduto: TEdit;
    lbQtdProduto: TLabel;
    edValorUnitarioProduto: TEdit;
    lbValorUnitarioProduto: TLabel;
    lbProduto: TLabel;
    sgProdutos: TStringGrid;
    btnAddProduto: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ConfigurarConexao;
  public
    { Public declarations }
  end;

var
  frmPedidosVenda: TfrmPedidosVenda;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmPedidosVenda.ConfigurarConexao;
begin
  Conexao.Connected := False;  // Desconectar caso esteja conectado
  Conexao.Params.Clear;
  Conexao.Params.LoadFromFile('config.ini');  // Carregar parâmetros do .ini
  try
    Conexao.Connected := True;
    ShowMessage('Conectado com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro na conexão: ' + E.Message);
  end;
end;

procedure TfrmPedidosVenda.FormCreate(Sender: TObject);
begin
  ConfigurarConexao;
end;

end.
