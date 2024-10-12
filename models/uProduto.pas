unit uProduto;

interface

type
  TProduto = class
  private
    FCodigo: Integer;
    FDescricao: String;
    FPrecoVenda: Double;
  public
    constructor Create(ACodigo: Integer; ADescricao: String; APrecoVenda: Double);

    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;
  end;

implementation

constructor TProduto.Create(ACodigo: Integer; ADescricao: String; APrecoVenda: Double);
begin
  FCodigo := ACodigo;
  FDescricao := ADescricao;
  FPrecoVenda := APrecoVenda;
end;

end.

