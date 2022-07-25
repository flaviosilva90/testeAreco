object frmProdutos: TfrmProdutos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Produtos'
  ClientHeight = 517
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object cxGrid: TcxGrid
    Left = 0
    Top = 271
    Width = 756
    Height = 246
    Cursor = crHandPoint
    Align = alBottom
    TabOrder = 0
    object cxGridDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = cxGridDBTableView1CellClick
      DataController.DataSource = Dtm.DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsSelection.MultiSelect = True
      object cxGridDBTableView1CODIGO_PRODUTO: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODIGO_PRODUTO'
        Options.Editing = False
      end
      object cxGridDBTableView1NOME_PRODUTO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'NOME_PRODUTO'
        Options.Editing = False
        Width = 295
      end
      object cxGridDBTableView1PRECO_PRODUTO: TcxGridDBColumn
        Caption = 'Pre'#231'o'
        DataBinding.FieldName = 'PRECO_PRODUTO'
        Options.Editing = False
      end
      object cxGridDBTableView1ESTOQUE_PRODUTO: TcxGridDBColumn
        Caption = 'Estoque'
        DataBinding.FieldName = 'ESTOQUE_PRODUTO'
        Options.Editing = False
      end
      object cxGridDBTableView1CATEGORIA_PRODUTO: TcxGridDBColumn
        Caption = 'Categoria'
        DataBinding.FieldName = 'CATEGORIA_PRODUTO'
        Options.Editing = False
        Width = 78
      end
      object cxGridDBTableView1SITUACAO_PRODUTO: TcxGridDBColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'SITUACAO_PRODUTO'
        Options.Editing = False
        Width = 80
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableView1
    end
  end
  object gbFormularioProdutos: TGroupBox
    Left = 8
    Top = 8
    Width = 745
    Height = 257
    Caption = 'Formul'#225'rio de Cadastro .: '
    TabOrder = 1
    object Label2: TLabel
      Left = 24
      Top = 31
      Width = 50
      Height = 19
      Caption = 'C'#243'digo'
    end
    object Label3: TLabel
      Left = 152
      Top = 31
      Width = 126
      Height = 19
      Caption = 'Nome do Produto'
    end
    object Label4: TLabel
      Left = 24
      Top = 104
      Width = 39
      Height = 19
      Caption = 'Pre'#231'o'
    end
    object Label5: TLabel
      Left = 120
      Top = 104
      Width = 56
      Height = 19
      Caption = 'Estoque'
    end
    object edtCodigoProd: TEdit
      Left = 24
      Top = 56
      Width = 73
      Height = 26
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnAdd: TButton
      Left = 102
      Top = 57
      Width = 36
      Height = 25
      Caption = '+'
      TabOrder = 1
      OnClick = btnAddClick
    end
    object edtNomeProd: TEdit
      Left = 152
      Top = 56
      Width = 561
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 2
    end
    object edtPrecoProd: TEdit
      Left = 24
      Top = 128
      Width = 73
      Height = 26
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtPrecoProdKeyPress
    end
    object edtEstoqueProd: TEdit
      Left = 120
      Top = 128
      Width = 73
      Height = 26
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      MaxLength = 4
      NumbersOnly = True
      ParentFont = False
      TabOrder = 4
    end
    object rgCategoria: TRadioGroup
      Left = 232
      Top = 104
      Width = 225
      Height = 105
      Caption = 'Categoria.: '
      Columns = 2
      Items.Strings = (
        'Alimento'
        'Bebida'
        'Limpeza'
        'Vestu'#225'rio')
      TabOrder = 5
    end
    object rgSituacao: TRadioGroup
      Left = 488
      Top = 104
      Width = 225
      Height = 105
      Caption = 'Situa'#231#227'o.: '
      Columns = 2
      Items.Strings = (
        'Ativo'
        'Inativo')
      TabOrder = 6
    end
    object btnGravar: TButton
      Left = 574
      Top = 224
      Width = 75
      Height = 25
      Caption = '&Gravar'
      TabOrder = 7
      OnClick = btnGravarClick
    end
    object BtnExcluir: TButton
      Left = 655
      Top = 224
      Width = 75
      Height = 25
      Caption = 'E&xcluir'
      TabOrder = 8
      OnClick = BtnExcluirClick
    end
  end
end
