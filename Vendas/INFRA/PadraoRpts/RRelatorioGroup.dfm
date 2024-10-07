object frmRelatorioGroup: TfrmRelatorioGroup
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio Gruop'
  ClientHeight = 683
  ClientWidth = 1924
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RLRelatorioGroup: TRLReport
    Left = -8
    Top = 0
    Width = 1123
    Height = 794
    DataSource = dsrpt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PageSetup.Orientation = poLandscape
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 53
      BandType = btHeader
      object rptInfoHora: TRLSystemInfo
        Left = 962
        Top = 18
        Width = 39
        Height = 16
        Info = itHour
        Text = ''
      end
      object RptInfoData: TRLSystemInfo
        Left = 880
        Top = 18
        Width = 39
        Height = 16
        Text = ''
      end
      object RLLHeader: TRLLabel
        Left = 399
        Top = 18
        Width = 78
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
        Top = 46
        Width = 1044
        Height = 7
        DrawKind = dkLine
      end
    end
    object RLGroup: TRLGroup
      Left = 38
      Top = 91
      Width = 1047
      Height = 96
    end
    object RLFooeter: TRLBand
      Left = 38
      Top = 187
      Width = 1047
      Height = 38
      BandType = btFooter
      object RLSIPage: TRLSystemInfo
        Left = 962
        Top = 14
        Width = 87
        Height = 16
        Info = itPageNumber
        Text = ''
      end
      object RLLPage: TRLLabel
        Left = 908
        Top = 14
        Width = 48
        Height = 16
        Caption = 'P'#225'gina:'
      end
      object RLDraw3: TRLDraw
        Left = 0
        Top = 4
        Width = 1049
        Height = 6
        DrawKind = dkLine
      end
    end
  end
  object cdsrpt: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 8
  end
  object dsrpt: TDataSource
    DataSet = cdsrpt
    Left = 448
    Top = 8
  end
end
