unit RptClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RRelatorio, RLFilters, RLPDFFilter,
  Data.DB, Datasnap.DBClient, RLReport,
  FactoryMethod.Controller.Interfaces;

type
  TRptRelClientes = class(TRptRelatorio)
    RLDBTCodigo: TRLDBText;
    RLDBTNome: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLDBTStatus: TRLDBText;
    procedure RelatoioBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
     FControllerCliente : iControllerCliente;
  public
    { Public declarations }
  end;

var
  RptRelClientes: TRptRelClientes;

implementation

{$R *.dfm}

procedure TRptRelClientes.RelatoioBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  FControllerCliente := TControllerCliente.New;
    FControllerCliente
    .EntidadesCliente
      .Cliente
        .DataSet(dsrpt)
      .RptSelects(0);
end;

end.
