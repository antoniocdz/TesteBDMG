object RptRelatorio: TRptRelatorio
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio'
  ClientHeight = 758
  ClientWidth = 1050
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Relatoio: TRLReport
    Left = -4
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dsrpt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 70
      BandType = btHeader
      object RLLHeader: TRLLabel
        Left = 304
        Top = 8
        Width = 77
        Height = 24
        Alignment = taCenter
        Caption = 'Header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 38
        Width = 715
        Height = 3
        DrawKind = dkLine
      end
      object RptInfoData: TRLSystemInfo
        Left = 568
        Top = 12
        Width = 39
        Height = 16
        Text = ''
      end
      object rptInfoHora: TRLSystemInfo
        Left = 642
        Top = 12
        Width = 39
        Height = 16
        Info = itHour
        Text = ''
      end
      object RLDraw2: TRLDraw
        Left = 0
        Top = 65
        Width = 715
        Height = 3
        DrawKind = dkLine
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 135
      Width = 718
      Height = 37
      BandType = btFooter
      object RodapeTotalClientes: TRLLabel
        Left = 16
        Top = 16
        Width = 36
        Height = 16
        Caption = 'Total:'
      end
      object TotalClientes: TRLSystemInfo
        Left = 58
        Top = 16
        Width = 51
        Height = 16
        Info = itRecNo
        Text = ''
      end
      object RLSIPage: TRLSystemInfo
        Left = 658
        Top = 16
        Width = 57
        Height = 16
        Info = itLastPageNumber
        Text = ''
      end
      object RLLPage: TRLLabel
        Left = 604
        Top = 16
        Width = 48
        Height = 16
        Caption = 'P'#225'gina:'
      end
      object RLDraw3: TRLDraw
        Left = 0
        Top = 9
        Width = 715
        Height = 3
        DrawKind = dkLine
      end
    end
    object Detalhe: TRLBand
      Left = 38
      Top = 108
      Width = 718
      Height = 27
    end
  end
  object dsrpt: TDataSource
    DataSet = cdsrpt
    Left = 480
    Top = 8
  end
  object cdsrpt: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 65528
  end
end
