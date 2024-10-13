unit uPedidoController;

interface

uses
  System.SysUtils, System.Classes, uPedido, System.Generics.Collections,
  FireDAC.Comp.Client,FireDAC.DApt, uProdutoPedido,Data.DB;

type
  TPedidoController = class
    private
      FConnection : TFDConnection;
    public
      constructor Create(AConnection:TFDConnection);
      procedure PostPedido(APedido:TPedido);
      function getPedidos : TObjectList<TPedido>;
      function getPedido(ANumeroPedido : Integer) : TDataSource;
      function getLastPedidoNumber : Integer;
      procedure DeletePedido(ACodigo:Integer);
  end;

implementation

{ TPedidoController }

constructor TPedidoController.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

procedure TPedidoController.DeletePedido(ACodigo: Integer);
var
  Query :TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConnection;
  try
    Query.Connection.StartTransaction;
    Query.SQL.Text := 'DELETE FROM produtos_pedido WHERE numero_pedido = :numero_pedido;';
    Query.ParamByName('numero_pedido').Value := ACodigo;
    Query.ExecSQL;

    Query.SQL.Clear;
    Query.Close;
    Query.SQL.Text:= 'DELETE FROM Pedidos WHERE numero_pedido = :numero_pedido;';
    Query.ParamByName('numero_pedido').Value := ACodigo;
    Query.ExecSQL;

    Query.Connection.Commit;
  except
    on e:Exception do
    begin
      Query.Connection.Rollback;
      raise Exception.Create('Error ao deletar pedido: '+ e.Message);
    end;
  end;
  Query.Free;
end;

function TPedidoController.getLastPedidoNumber: Integer;
var
   Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConnection;
  try
    Query.SQL.Text := 'SELECT IFNULL(numero_pedido,0) as numero_pedido FROM pedidos ORDER BY numero_pedido desc LIMIT 1;';
    Query.Open;
    Result := Query.FieldByName('numero_pedido').AsInteger;
  except
    on e:exception do
    begin
      raise Exception.Create('Error Message'+e.Message);
    end;
  end;
  Query.Free;
end;

function TPedidoController.getPedido(
  ANumeroPedido: Integer): TDataSource;
var
  Query:TFDQuery;
  ds : TDataSource;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConnection;
  ds := TDataSource.Create(nil);

  try
    Query.SQL.Text :=' SELECT '
                    +'	p.Numero_pedido'
                    +'  ,p.data_emissao'
                    +'  ,p.codigo_cliente'
                    +'  ,p.valor_total AS valor_total_pedido'
                    +'  ,pp.codigo_produto'
                    +'  ,pp.quantidade'
                    +'  ,pp.valor_unitario'
                    +'  ,pp.valor_total AS valor_total_produto'
                    +' FROM '
                    +'	Pedidos p'
                    +'	INNER JOIN Produtos_pedido pp'
                    +'		ON p.Numero_pedido = pp.Numero_pedido'
                    +'  WHERE p.numero_pedido = :numero_pedido';

    Query.ParamByName('numero_pedido').Value := ANumeroPedido;
    Query.Open;

    ds.DataSet:= Query;
    Result := ds;
  except
    on e:exception do
    begin
      ds.Free;
      raise Exception.CreateFmt('Erro ao obter Pedido: %s', [E.Message]);
    end;
  end;
end;

function TPedidoController.getPedidos: TObjectList<TPedido>;
var
  Query: TFDQuery;
  Pedidos : TObjectList<TPedido>;
begin
  Pedidos := TObjectList<TPedido>.Create;
  Query := TFDQuery.Create(nil);
  Query.Connection := FConnection;
  try
    Query.SQL.Text := 'Select numero_pedido, data_emissao, codigo_cliente, valor_total FROM pedidos ORDER BY numero_pedido';
    Query.Open();

    while not Query.Eof do
    begin
      Pedidos.Add( TPedido.Create(Query.FieldByName('numero_pedido').AsInteger,
                   Query.FieldByName('data_emissao').AsDateTime,
                   Query.FieldByName('codigo_cliente').AsInteger,
                   Query.FieldByName('valor_total').AsFloat) );
      Query.Next;
    end;
    Result := Pedidos;
  except
    on e:Exception do
    begin
      Pedidos.Free;
      raise Exception.Create('Error Message'+e.Message);
    end;
  end;
  Query.Free;
end;

procedure TPedidoController.PostPedido(APedido: TPedido);
var
  Query : TFDQuery;
  produtoPedido : TProdutoPedido;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConnection;

  try
    Query.Connection.StartTransaction;

    Query.SQL.Text := 'INSERT INTO pedidos '
                    + '(data_emissao, codigo_cliente, valor_total) '
                    + 'VALUES (:data_emissao, :codigo_cliente, :valor_total);';

    Query.ParamByName('data_emissao').Value := APedido.DataEmissao;
    Query.ParamByName('codigo_cliente').Value := APedido.CodigoCliente;
    Query.ParamByName('valor_total').Value := APedido.ValorTotal;

    Query.ExecSQL;

    Query.Close;
    Query.SQL.Clear;

    Query.SQL.Text := 'INSERT INTO produtos_pedido '
                    + '( numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) '
                    + 'VALUES ( :numero_pedido, :codigo_produto, :quantidade, :valor_unitario, :valor_total) ';

    for produtoPedido in APedido.Produtos do
    begin
      produtoPedido.NumeroPedido := getLastPedidoNumber;
      Query.ParamByName('numero_pedido').Value := produtoPedido.NumeroPedido;
      Query.ParamByName('codigo_produto').Value := produtoPedido.CodigoProduto;
      Query.ParamByName('quantidade').Value := produtoPedido.Quantidade;
      Query.ParamByName('valor_unitario').Value := produtoPedido.ValorUnitario;
      Query.ParamByName('valor_total').Value := produtoPedido.ValorTotal;

      Query.ExecSQL;
      Query.Connection.Commit;
    end;

  except
    on E:Exception do
    begin
      Query.Connection.Rollback;
      raise Exception.Create('Error Message'+E.Message);
    end;
  end;
  Query.Free;
end;

end.
