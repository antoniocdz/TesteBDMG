inherited frmcadFornecedores: TfrmcadFornecedores
  Caption = 'Cadastro de Fornecedores'
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
      object edtrazaosocial: TLabeledEdit
        Tag = 2
        Left = 5
        Top = 70
        Width = 443
        Height = 23
        EditLabel.Width = 65
        EditLabel.Height = 15
        EditLabel.Caption = 'Raz'#227'o Social'
        MaxLength = 100
        TabOrder = 0
        Text = ''
      end
      object rgStatus: TRadioGroup
        Tag = 2
        Left = 5
        Top = 191
        Width = 122
        Height = 65
        Caption = 'Status'
        Items.Strings = (
          'Ativo'
          'Inativo')
        TabOrder = 4
      end
      object edtCNPJ: TLabeledEdit
        Tag = 2
        Left = 5
        Top = 162
        Width = 120
        Height = 23
        EditLabel.Width = 27
        EditLabel.Height = 15
        EditLabel.Caption = 'CNPJ'
        EditMask = '##.###.###/####-##'
        MaxLength = 18
        NumbersOnly = True
        TabOrder = 3
        Text = '  .   .   /    -  '
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
        TabOrder = 2
        Text = ''
      end
      object edtnomefantasia: TLabeledEdit
        Tag = 2
        Left = 5
        Top = 115
        Width = 443
        Height = 23
        EditLabel.Width = 79
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome Fantasia'
        MaxLength = 100
        TabOrder = 1
        Text = ''
      end
    end
  end
end
