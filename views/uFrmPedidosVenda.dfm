object frmPedidosVenda: TfrmPedidosVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 530
  ClientWidth = 999
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object lbClientes: TLabel
    Left = 40
    Top = 43
    Width = 100
    Height = 15
    Caption = 'Selecione o Cliente'
  end
  object cbClientes: TComboBox
    Left = 40
    Top = 64
    Width = 177
    Height = 23
    TabOrder = 0
    Text = 'cbClientes'
  end
  object pnProduto: TPanel
    Left = 40
    Top = 93
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
    Left = 794
    Top = 196
    Width = 111
    Height = 33
    Caption = 'Inserir Produto'
    TabOrder = 2
    OnClick = btnAddProdutoClick
  end
  object dbgProdutos: TDBGrid
    Left = 40
    Top = 235
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
    Top = 489
    Width = 999
    Height = 41
    Align = alBottom
    TabOrder = 4
    ExplicitLeft = 329
    ExplicitTop = 456
    ExplicitWidth = 185
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 768
      Top = 4
      Width = 227
      Height = 33
      Align = alRight
      TabOrder = 0
      object lbValorTotalPedido: TLabel
        AlignWithMargins = True
        Left = 168
        Top = 4
        Width = 55
        Height = 25
        Align = alRight
        Alignment = taCenter
        Caption = '0,00'
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 81
        Top = 4
        Width = 81
        Height = 25
        Align = alRight
        Alignment = taCenter
        Caption = 'Valor Total: R$ -'
        ExplicitLeft = 84
        ExplicitHeight = 15
      end
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'LIBMYSQLx86.dll'
    Left = 656
    Top = 16
  end
end
