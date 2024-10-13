unit uProdutoPedidoController;

interface

uses
  System.SysUtils, System.Classes, uProdutoPedido, System.Generics.Collections,
  FireDAC.Comp.Client,FireDAC.DApt;

type
  TProdutoPedidoController = class
  private
    FConnection : TFDConnection;
  public
  constructor Create(AConnection: TFDConnection);

  end;

implementation

{ TProdutoPedidoController }

constructor TProdutoPedidoController.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

end.
