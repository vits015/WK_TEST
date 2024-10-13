object frmPedidosVenda: TfrmPedidosVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 648
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object lbClientes: TLabel
    Left = 17
    Top = 35
    Width = 100
    Height = 15
    Caption = 'Selecione o Cliente'
  end
  object lbNumPedido: TLabel
    Left = 836
    Top = 8
    Width = 13
    Height = 32
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lbPedido: TLabel
    Left = 702
    Top = 8
    Width = 120
    Height = 32
    Caption = 'Pedido N'#186': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object cbClientes: TComboBox
    Left = 17
    Top = 56
    Width = 177
    Height = 23
    TabOrder = 0
    Text = 'cbClientes'
    OnSelect = cbClientesSelect
  end
  object pnProduto: TPanel
    Left = 8
    Top = 141
    Width = 865
    Height = 97
    TabOrder = 1
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
      Left = 289
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
  end
  object btnAddProduto: TButton
    Left = 762
    Top = 244
    Width = 111
    Height = 33
    Caption = 'Inserir Produto'
    TabOrder = 2
    OnClick = btnAddProdutoClick
  end
  object dbgProdutos: TDBGrid
    Left = 8
    Top = 283
    Width = 865
    Height = 238
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = dbgProdutosKeyDown
  end
  object pnRodape: TPanel
    Left = 0
    Top = 607
    Width = 884
    Height = 41
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 529
    ExplicitWidth = 876
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 653
      Top = 4
      Width = 227
      Height = 33
      Align = alRight
      TabOrder = 0
      ExplicitLeft = 645
      object lbValorTotalPedido: TLabel
        AlignWithMargins = True
        Left = 202
        Top = 4
        Width = 21
        Height = 25
        Align = alRight
        Alignment = taCenter
        Caption = '0,00'
        ExplicitHeight = 15
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 115
        Top = 4
        Width = 81
        Height = 25
        Align = alRight
        Alignment = taCenter
        Caption = 'Valor Total: R$ -'
        ExplicitHeight = 15
      end
    end
  end
  object btnSalvarPedido: TButton
    Left = 762
    Top = 552
    Width = 105
    Height = 41
    Caption = 'Salvar Pedido'
    TabOrder = 5
    OnClick = btnSalvarPedidoClick
  end
  object pnCarregarPedido: TPanel
    Left = 346
    Top = 23
    Width = 295
    Height = 88
    TabOrder = 6
    object lbNumPedidoEdit: TLabel
      Left = 152
      Top = 20
      Width = 54
      Height = 15
      Caption = 'N'#186' Pedido'
    end
    object btnCarregarPedido: TButton
      Left = 20
      Top = 25
      Width = 105
      Height = 39
      Caption = 'Carregar Pedido'
      TabOrder = 0
      OnClick = btnCarregarPedidoClick
    end
    object edNumPedido: TEdit
      Left = 147
      Top = 41
      Width = 121
      Height = 23
      TabOrder = 1
    end
  end
  object btnLimparCliente: TButton
    Left = 200
    Top = 55
    Width = 97
    Height = 25
    Caption = 'Limpar Cliente'
    TabOrder = 7
    OnClick = btnLimparClienteClick
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'LIBMYSQLx86.dll'
    Left = 656
    Top = 16
  end
end
