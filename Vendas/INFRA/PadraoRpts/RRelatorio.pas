unit RRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, RLReport, RLFilters;


type
  TRptRelatorio = class(TForm)
    dsrpt: TDataSource;
    cdsrpt: TClientDataSet;
    Relatoio: TRLReport;
    Cabecalho: TRLBand;
    RLLHeader: TRLLabel;
    RLDraw1: TRLDraw;
    Rodape: TRLBand;
    RptInfoData: TRLSystemInfo;
    rptInfoHora: TRLSystemInfo;
    Detalhe: TRLBand;
    RodapeTotalClientes: TRLLabel;
    TotalClientes: TRLSystemInfo;
    RLSIPage: TRLSystemInfo;
    RLLPage: TRLLabel;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
  private

  public

  end;

var
  RptRelatorio: TRptRelatorio;

implementation

{$R *.dfm}

end.
