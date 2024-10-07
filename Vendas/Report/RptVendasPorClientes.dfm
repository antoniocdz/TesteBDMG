inherited RptVendasporCli: TRptVendasporCli
  Caption = 'RptVendasporCli'
  TextHeight = 15
  inherited Relatoio: TRLReport
    Width = 1123
    Height = 794
    PageSetup.Orientation = poLandscape
    BeforePrint = RelatoioBeforePrint
    ExplicitWidth = 1123
    ExplicitHeight = 794
    inherited Cabecalho: TRLBand
      Width = 1047
      ExplicitWidth = 1047
      inherited RLLHeader: TRLLabel
        Left = 94
        Width = 737
        Caption = 'Vendas por Clientes'
        ExplicitLeft = 94
        ExplicitWidth = 737
      end
      inherited RLDraw1: TRLDraw
        Top = 37
        Width = 1010
        Height = 1
      end
      inherited RptInfoData: TRLSystemInfo
        Left = 869
        Top = 16
        ExplicitLeft = 869
        ExplicitTop = 16
      end
      inherited rptInfoHora: TRLSystemInfo
        Left = 943
        Top = 16
        ExplicitLeft = 943
        ExplicitTop = 16
      end
      inherited RLDraw2: TRLDraw
        Width = 1010
        Height = 5
      end
      object RLLabel5: TRLLabel
        Left = 944
        Top = 43
        Width = 42
        Height = 16
        Caption = 'Status'
      end
      object RLLabel6: TRLLabel
        Left = 848
        Top = 43
        Width = 81
        Height = 16
        Caption = 'Total Produto'
      end
      object RLLabel4: TRLLabel
        Left = 390
        Top = 44
        Width = 50
        Height = 16
        Caption = 'Produto'
      end
      object RLLabel3: TRLLabel
        Left = 221
        Top = 43
        Width = 44
        Height = 16
        Caption = 'Cliente'
      end
      object RLLabel2: TRLLabel
        Left = 94
        Top = 43
        Width = 72
        Height = 16
        Caption = 'Data Venda'
      end
      object RLLabel1: TRLLabel
        Left = 3
        Top = 43
        Width = 76
        Height = 16
        Caption = 'Num. Venda'
      end
      object RLLabel7: TRLLabel
        Left = 663
        Top = 43
        Width = 61
        Height = 16
        Caption = 'Pre'#231'oUnit'
      end
      object RLLabel8: TRLLabel
        Left = 761
        Top = 43
        Width = 70
        Height = 16
        Caption = 'Quantidade'
      end
    end
    inherited Rodape: TRLBand
      Top = 134
      Width = 1047
      ExplicitTop = 134
      ExplicitWidth = 1047
      inherited RLSIPage: TRLSystemInfo
        Left = 953
        Top = 15
        ExplicitLeft = 953
        ExplicitTop = 15
      end
      inherited RLLPage: TRLLabel
        Left = 899
        Top = 15
        ExplicitLeft = 899
        ExplicitTop = 15
      end
      inherited RLDraw3: TRLDraw
        Width = 1010
        Height = 1
      end
    end
    inherited Detalhe: TRLBand
      Width = 1047
      Height = 26
      Font.Height = -12
      ParentFont = False
      ExplicitWidth = 1047
      ExplicitHeight = 26
      object RLDBTNumVenda: TRLDBText
        Left = 6
        Top = 6
        Width = 65
        Height = 15
        DataField = 'NumVenda'
        DataSource = dsrpt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBTDataVenda: TRLDBText
        Left = 94
        Top = 6
        Width = 62
        Height = 15
        DataField = 'Datavenda'
        DataSource = dsrpt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBTCliente: TRLDBText
        Left = 221
        Top = 4
        Width = 42
        Height = 15
        DataField = 'Cliente'
        DataSource = dsrpt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBTProduto: TRLDBText
        Left = 390
        Top = 6
        Width = 46
        Height = 15
        DataField = 'Produto'
        DataSource = dsrpt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBTPrecoUnit: TRLDBText
        Left = 663
        Top = 4
        Width = 57
        Height = 15
        DataField = 'PrecoUnit'
        DataSource = dsrpt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBTQuantidade: TRLDBText
        Left = 761
        Top = 4
        Width = 67
        Height = 15
        DataField = 'Quantidade'
        DataSource = dsrpt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object TotalProd: TRLDBText
        Left = 851
        Top = 5
        Width = 73
        Height = 15
        DataField = 'TotalProduto'
        DataSource = dsrpt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBTStatus: TRLDBText
        Left = 944
        Top = 5
        Width = 80
        Height = 15
        DataField = 'StatusVendas'
        DataSource = dsrpt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
    end
  end
end
