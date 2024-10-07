unit RptVendasPorCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RRelatorioGroup, RLReport, Data.DB,
  Datasnap.DBClient, FactoryMethod.Controller.Interfaces;

type
  TfrmRelatorioGVendasporCliente = class(TfrmRelatorioGroup)
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel1: TRLLabel;
    RLDraw2: TRLDraw;
    RLDBTDataVenda: TRLDBText;
    RLDBTNumVenda: TRLDBText;
    RLDBTCliente: TRLDBText;
    RLDBTProduto: TRLDBText;
    RLDBTPrecoUnit: TRLDBText;
    RLDBTQuantidade: TRLDBText;
    TotalProd: TRLDBText;
    RLDBTStatus: TRLDBText;
    RLBand4: TRLBand;
    RLDraw4: TRLDraw;
    RLLabel9: TRLLabel;
    RLDBRTotalVenda: TRLDBResult;
    procedure RLRelatorioGroupBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    FControllerPreVenda   : iControllerPreVenda;
  public
    { Public declarations }
  end;

var
  frmRelatorioGVendasporCliente: TfrmRelatorioGVendasporCliente;

implementation

{$R *.dfm}

procedure TfrmRelatorioGVendasporCliente.RLRelatorioGroupBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;
  FControllerPreVenda := TControllerPreVenda.New;
    FControllerPreVenda
    .EntidadesPreVenda
      .PreVenda
        .DataSet(dsrpt)
      .RptSelects(1);
end;

end.
