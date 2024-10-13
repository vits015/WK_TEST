object frmPedidosVenda: TfrmPedidosVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 647
  ClientWidth = 880
  Color = 3487029
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object pnProduto: TPanel
    Left = 8
    Top = 157
    Width = 865
    Height = 97
    TabOrder = 0
    object lbCodProduto: TLabel
      Left = 9
      Top = 43
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object lbQtdProduto: TLabel
      Left = 513
      Top = 43
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object lbValorUnitarioProduto: TLabel
      Left = 409
      Top = 43
      Width = 70
      Height = 15
      Caption = 'Valor unit'#225'iro'
    end
    object lbProduto: TLabel
      Left = 385
      Top = 6
      Width = 43
      Height = 15
      Caption = 'Produto'
    end
    object lbDescricaoProduto: TLabel
      Left = 121
      Top = 43
      Width = 51
      Height = 15
      Caption = 'Descricao'
    end
    object edCodigoProduto: TEdit
      Left = 9
      Top = 64
      Width = 84
      Height = 23
      TabOrder = 0
      OnExit = edCodigoProdutoExit
    end
    object edQtdProduto: TEdit
      Left = 505
      Top = 64
      Width = 84
      Height = 23
      TabOrder = 1
    end
    object edValorUnitarioProduto: TEdit
      Left = 409
      Top = 64
      Width = 84
      Height = 23
      TabOrder = 2
    end
    object edDescricaoProduto: TEdit
      Left = 121
      Top = 64
      Width = 256
      Height = 23
      ImeName = 'Portuguese (Brazilian ABNT)'
      TabOrder = 3
    end
    object btnAddProduto: TButton
      Left = 738
      Top = 56
      Width = 111
      Height = 33
      Caption = 'Inserir Produto'
      TabOrder = 4
      OnClick = btnAddProdutoClick
    end
  end
  object dbgProdutos: TDBGrid
    Left = 8
    Top = 283
    Width = 865
    Height = 238
    Color = cl3DDkShadow
    FixedColor = clMedGray
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = dbgProdutosKeyDown
  end
  object pnRodape: TPanel
    Left = 0
    Top = 606
    Width = 880
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = -3
    ExplicitWidth = 876
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 649
      Top = 4
      Width = 227
      Height = 33
      Align = alRight
      TabOrder = 0
      ExplicitLeft = 646
      ExplicitTop = 1
      object lbValorTotalPedido: TLabel
        AlignWithMargins = True
        Left = 138
        Top = 4
        Width = 38
        Height = 25
        Align = alLeft
        Alignment = taCenter
        Caption = '0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 202
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 128
        Height = 25
        Align = alLeft
        Alignment = taCenter
        Caption = 'Valor Total: R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 51
        ExplicitTop = 20
      end
    end
  end
  object btnSalvarPedido: TButton
    Left = 767
    Top = 559
    Width = 105
    Height = 41
    Caption = 'Salvar Pedido'
    TabOrder = 3
    OnClick = btnSalvarPedidoClick
  end
  object pnCarregarPedido: TPanel
    Left = 498
    Top = 23
    Width = 303
    Height = 112
    TabOrder = 4
    object lbNumPedidoEdit: TLabel
      Left = 160
      Top = 32
      Width = 54
      Height = 15
      Caption = 'N'#186' Pedido'
    end
    object btnCarregarPedido: TButton
      Left = 20
      Top = 8
      Width = 105
      Height = 39
      Caption = 'Carregar Pedido'
      TabOrder = 0
      OnClick = btnCarregarPedidoClick
    end
    object edNumPedido: TEdit
      Left = 155
      Top = 53
      Width = 121
      Height = 23
      TabOrder = 1
    end
    object btnCancelarPedido: TButton
      Left = 20
      Top = 64
      Width = 105
      Height = 39
      Caption = 'Cancelar Pedido'
      TabOrder = 2
      OnClick = btnCancelarPedidoClick
    end
  end
  object pnCliente: TPanel
    Left = 23
    Top = 8
    Width = 317
    Height = 111
    TabOrder = 5
    object lbClientes: TLabel
      Left = 17
      Top = 35
      Width = 100
      Height = 15
      Caption = 'Selecione o Cliente'
    end
    object btnLimparCliente: TButton
      Left = 200
      Top = 55
      Width = 97
      Height = 25
      Caption = 'Limpar Cliente'
      TabOrder = 0
      OnClick = btnLimparClienteClick
    end
    object cbClientes: TComboBox
      Left = 17
      Top = 56
      Width = 177
      Height = 23
      TabOrder = 1
      Text = 'cbClientes'
      OnSelect = cbClientesSelect
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'LIBMYSQLx86.dll'
    Left = 832
    Top = 16
  end
end
