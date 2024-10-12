unit uProdutoPedido;

interface

type
  TProdutoPedido = class
  private
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Integer;
    FValorUnitario: Double;
    FValorTotal: Double;
  public
    constructor Create(ANumeroPedido, ACodigoProduto, AQuantidade: Integer; AValorUnitario: Double);

    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

constructor TProdutoPedido.Create(ANumeroPedido, ACodigoProduto, AQuantidade: Integer; AValorUnitario: Double);
begin
  FNumeroPedido := ANumeroPedido;
  FCodigoProduto := ACodigoProduto;
  FQuantidade := AQuantidade;
  FValorUnitario := AValorUnitario;
  FValorTotal := FQuantidade * FValorUnitario;
end;

end.

