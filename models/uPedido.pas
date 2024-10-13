unit uPedido;

interface

uses
  System.Generics.Collections, uProdutoPedido;

type
  TPedido = class
  private
    FNumero: Integer;
    FDataEmissao: TDateTime;
    FCodigoCliente: Integer;
    FValorTotal: Double;
    FProdutos: TObjectList<TProdutoPedido>;
  public
    constructor Create(ANumeroPedido:Integer; ADataEmissao: TDateTime; ACodigoCliente: Integer; AValorTotal: Double);
    destructor Destroy; override;

    property Numero: Integer read FNumero write FNumero;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property Produtos: TObjectList<TProdutoPedido> read FProdutos write FProdutos;

    procedure AdicionarProduto(AProdutoPedido: TProdutoPedido);
    procedure RemoverProduto(AProdutoPedido: TProdutoPedido);
  end;

implementation

constructor TPedido.Create(ANumeroPedido:Integer; ADataEmissao: TDateTime; ACodigoCliente: Integer; AValorTotal: Double);
begin
  FNumero := ANumeroPedido;
  FDataEmissao := ADataEmissao;
  FCodigoCliente := ACodigoCliente;
  FValorTotal := AValorTotal;
  FProdutos := TObjectList<TProdutoPedido>.Create;
end;

destructor TPedido.Destroy;
begin
  FProdutos.Free;
  inherited;
end;

procedure TPedido.AdicionarProduto(AProdutoPedido: TProdutoPedido);
begin
  FProdutos.Add(AProdutoPedido);
end;

procedure TPedido.RemoverProduto(AProdutoPedido: TProdutoPedido);
begin
  FProdutos.Remove(AProdutoPedido);
end;

end.

