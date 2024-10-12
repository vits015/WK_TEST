object frmPedidosVenda: TfrmPedidosVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 530
  ClientWidth = 709
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
  object ComboBox1: TComboBox
    Left = 40
    Top = 64
    Width = 177
    Height = 23
    ImeName = 'cbCliente'
    TabOrder = 0
    Text = 'ComboBox1'
  end
  object pnProduto: TPanel
    Left = 40
    Top = 93
    Width = 369
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
      Left = 145
      Top = 43
      Width = 72
      Height = 15
      Caption = 'Quantidade'
    end
    object lbValorUnitarioProduto: TLabel
      Left = 257
      Top = 43
      Width = 70
      Height = 15
      Caption = 'Valor unit'#225'iro'
    end
    object lbProduto: TLabel
      Left = 145
      Top = 6
      Width = 43
      Height = 15
      Caption = 'Produto'
    end
    object edCodigoProduto: TEdit
      Left = 9
      Top = 64
      Width = 84
      Height = 23
      TabOrder = 0
    end
    object edQtdProduto: TEdit
      Left = 145
      Top = 64
      Width = 84
      Height = 23
      TabOrder = 1
    end
    object edValorUnitarioProduto: TEdit
      Left = 257
      Top = 64
      Width = 84
      Height = 23
      TabOrder = 2
    end
  end
  object sgProdutos: TStringGrid
    Left = 40
    Top = 232
    Width = 473
    Height = 177
    TabOrder = 2
  end
  object btnAddProduto: TButton
    Left = 434
    Top = 128
    Width = 111
    Height = 33
    Caption = 'Inserir Produto'
    TabOrder = 3
  end
  object Conexao: TFDConnection
    LoginPrompt = False
    Left = 664
    Top = 8
  end
  object DriverMySQL: TFDPhysMySQLDriverLink
    VendorLib = 'LIBMYSQLx86.DLL'
    Left = 600
    Top = 8
  end
end
