inherited frmcadProdutos: TfrmcadProdutos
  Caption = 'Cadastro de Produtos'
  TextHeight = 15
  inherited pnrodape: TPanel
    inherited bdnNavegar: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited pnCabecalho: TPanel
        inherited btnPesquisar: TBitBtn
          OnClick = btnPesquisarClick
        end
      end
    end
    inherited tabManutencao: TTabSheet
      object lbFornecedor: TLabel
        Left = 3
        Top = 144
        Width = 60
        Height = 15
        Caption = 'Fornecedor'
      end
      object Label2: TLabel
        Left = 3
        Top = 99
        Width = 75
        Height = 15
        Caption = 'Pre'#231'o Unit'#225'rio'
      end
      object rgStatus: TRadioGroup
        Tag = 2
        Left = 3
        Top = 192
        Width = 122
        Height = 65
        Caption = 'Status'
        Items.Strings = (
          'Ativo'
          'Inativo')
        TabOrder = 4
      end
      object edtdescricaoprod: TLabeledEdit
        Tag = 2
        Left = 5
        Top = 70
        Width = 444
        Height = 23
        EditLabel.Width = 51
        EditLabel.Height = 15
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 100
        TabOrder = 1
        Text = ''
      end
      object edtCodigo: TLabeledEdit
        Tag = 1
        Left = 5
        Top = 25
        Width = 121
        Height = 23
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object dblcbListaForn: TDBLookupComboBox
        Tag = 2
        Left = 3
        Top = 163
        Width = 444
        Height = 23
        KeyField = 'Codigo'
        ListField = 'Fornecedor'
        ListSource = dsaux
        TabOrder = 3
      end
      object edtPrecoUnitario: TCurrencyEdit
        Tag = 2
        Left = 3
        Top = 115
        Width = 121
        Height = 23
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 2
        Text = '0,00'
        FormatMask = '###,##0.00'
      end
    end
  end
  inherited dsPadrao: TDataSource
    Left = 696
    Top = 80
  end
  inherited cdsPesquisa: TClientDataSet
    Left = 644
    Top = 82
  end
  inherited cdsaux: TClientDataSet
    Left = 652
    Top = 26
  end
  inherited dsaux: TDataSource
    Left = 700
    Top = 26
  end
end
