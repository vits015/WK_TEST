unit uClienteController;

interface

uses
  System.SysUtils, System.Classes, uCliente, System.Generics.Collections,
  FireDAC.Comp.Client,FireDAC.DApt;

type
  TClienteController = class
  private
    FConnection:TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function getClientes : TObjectList<TCliente>; // Retorna uma lista de clientes
  end;

implementation

{ TClienteController }

function TClienteController.getClientes : TObjectList<TCliente>;
var
  Query: TFDQuery;
  Cliente: TCliente;
  Clientes: TObjectList<TCliente>;
begin
  Clientes := TObjectList<TCliente>.Create; // Inicializa a lista
  Query := TFDQuery.Create(nil); // Cria a query
  try
    Query.Connection := FConnection; // Atribui a conexão
    Query.SQL.Text := 'SELECT Codigo, Nome, Cidade, UF FROM Clientes order by codigo';
    Query.Open;

    while not Query.Eof do
    begin
      Cliente := TCliente.Create(Query.FieldByName('Codigo').AsInteger,
                                 Query.FieldByName('Nome').AsString,
                                 Query.FieldByName('Cidade').AsString,
                                 Query.FieldByName('UF').AsString);
      Clientes.Add(Cliente); // Adiciona o cliente na lista
      Query.Next;
    end;

    Result := Clientes; // Retorna a lista preenchida
  except
    on E: Exception do
    begin
      Clientes.Free; // Libera a lista se ocorrer erro
      raise Exception.Create('Erro ao carregar Cliente: '+ e.Message);
    end;
  end;
  Query.Free; // Libera a query
end;

constructor TClienteController.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

end.

