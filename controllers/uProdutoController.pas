unit uProdutoController;

interface

  uses
    System.sysUtils, System.Classes, uProduto, System.Generics.Collections,
    FireDAC.Comp.Client, FireDAC.DApt;

  type
    TProdutoController = class
    private
      FConnection : TFDConnection;
    public
      constructor Create(AConnection: TFDConnection);
      function getProdutos : TObjectList<TProduto>; overload;
      function getProdutos(ACodigo:Integer): TObjectList<TProduto>; overload;

    end;

implementation

{ TProdutoController }

function TProdutoController.getProdutos : TObjectList<TProduto>;
var
  Query: TFDQuery;
  Produto: TProduto;
  Produtos: TObjectList<TProduto>;
begin
  Produtos := TObjectList<TProduto>.Create;
  Query:= TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.text := 'SELECT Codigo, Descricao, Preco_venda FROM Produtos order by codigo';
    Query.Open;

    while not Query.Eof do
    begin
      Produto := TProduto.Create( Query.FieldByName('Codigo').AsInteger,
                                  Query.FieldByName('Descricao').AsString,
                                  Query.FieldByName('PrecoVenda').AsFloat);
      Produtos.Add(Produto);
      Query.Next;
    end;

    Result := Produtos;

  except
    on E:Exception do
    begin      
      Produtos.Free;
      raise Exception.Create('Erro ao carregar produtos: '+ E.Message);
    end;
  end;
  Query.Free;
end;

constructor TProdutoController.Create(Aconnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TProdutoController.getProdutos(
  ACodigo: Integer): TObjectList<TProduto>;
var
  Query: TFDQuery;
  Produto: TProduto;
  Produtos: TObjectList<TProduto>;
begin
  Produtos := TObjectList<TProduto>.Create;
  Query:= TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.text := 'SELECT Codigo, Descricao, Preco_venda FROM Produtos WHERE Codigo = :codigo order by codigo';
    Query.ParamByName('codigo').Value := ACodigo;
    Query.Open;

    while not Query.Eof do
    begin
      Produto := TProduto.Create( Query.FieldByName('Codigo').AsInteger,
                                  Query.FieldByName('Descricao').AsString,
                                  Query.FieldByName('Preco_Venda').AsFloat);
      Produtos.Add(Produto);
      Query.Next;
    end;

    Result := Produtos;

  except
    on E:Exception do
    begin      
      Produtos.Free;
      raise Exception.Create('Erro ao carregar produtos: '+ E.Message);
    end;
  end;
  Query.Free;
end;

end.
