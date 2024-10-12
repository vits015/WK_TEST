program WK_TEST;

uses
  Vcl.Forms,
  uFrmPedidosVenda in 'views\uFrmPedidosVenda.pas' {frmPedidosVenda},
  uCliente in 'models\uCliente.pas',
  uProduto in 'models\uProduto.pas',
  uPedido in 'models\uPedido.pas',
  uProdutoPedido in 'models\uProdutoPedido.pas',
  uClienteController in 'controllers\uClienteController.pas',
  uProdutoController in 'controllers\uProdutoController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedidosVenda, frmPedidosVenda);
  Application.Run;
end.
