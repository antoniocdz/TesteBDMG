unit RRelatorioGroup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, Datasnap.DBClient;

type
  TfrmRelatorioGroup = class(TForm)
    RLRelatorioGroup: TRLReport;
    RLBand1: TRLBand;
    RLGroup: TRLGroup;
    RLFooeter: TRLBand;
    rptInfoHora: TRLSystemInfo;
    RptInfoData: TRLSystemInfo;
    RLLHeader: TRLLabel;
    RLDraw1: TRLDraw;
    RLSIPage: TRLSystemInfo;
    RLLPage: TRLLabel;
    RLDraw3: TRLDraw;
    cdsrpt: TClientDataSet;
    dsrpt: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioGroup: TfrmRelatorioGroup;

implementation

{$R *.dfm}

end.
