unit Vendas.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, RLReport, Enter;

type
  TfrmPrincipal = class(TForm)
    mMenu: TMainMenu;
    Cadastros: TMenuItem;
    Movimentao: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    Vendas1: TMenuItem;
    frmClientes: TMenuItem;
    frmFornecedores: TMenuItem;
    frmProdutos: TMenuItem;
    rptClientes: TMenuItem;
    rptVendasPorClientes: TMenuItem;
    imglogo: TImage;
    procedure Sair1Click(Sender: TObject);
    procedure frmClientesClick(Sender: TObject);
    procedure frmFornecedoresClick(Sender: TObject);
    procedure frmProdutosClick(Sender: TObject);
    procedure rptClientesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Vendas1Click(Sender: TObject);
    procedure rptVendasPorClientesClick(Sender: TObject);
  private
    TeclaEnter: TMREnter;
    procedure AbreForm(aClasseForm: TComponentClass; var aForm);
    procedure AbreRpt(aClasseRpt: TFormClass);

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation
uses
  Vendas.View.CadClientes,
  Vendas.View.CadFornecedores,
  Vendas.View.CadProdutos,
  Vendas.View.PreVendas,
  RptClientes,
  RptVendasPorCliente;

{$R *.dfm}

procedure TfrmPrincipal.AbreForm(aClasseForm: TComponentClass; var aForm);
begin
  try
    Application.CreateForm(aClasseForm,aForm);
    Tform(aForm).ShowModal;
  finally
    FreeAndNil(Tform(aForm));
  end;
end;

procedure TfrmPrincipal.AbreRpt(aClasseRpt: TFormClass);
var
 rpt: TForm;
 i:Integer;
begin
  try
    rpt := aClasseRpt.Create(Application);
    for I := 0 to rpt.ComponentCount-1 do
    begin
      if rpt.Components[i] is TRLReport then
      begin
         TRLReport(rpt.Components[i]).PreviewModal;
         Break;
      end;
    end;
  finally
    if Assigned(rpt) then
       rpt.Release;
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if TeclaEnter <> nil
   then FreeAndNil(TeclaEnter);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  TeclaEnter:= TMREnter.Create(Self);
  TeclaEnter.FocusEnabled:= True;
  TeclaEnter.FocusColor:= clInfoBk;
end;

procedure TfrmPrincipal.frmClientesClick(Sender: TObject);
begin
  AbreForm(TfrmcadClientes, frmcadClientes);
end;

procedure TfrmPrincipal.frmFornecedoresClick(Sender: TObject);
begin
    AbreForm(TfrmcadFornecedores, frmcadFornecedores);
end;

procedure TfrmPrincipal.frmProdutosClick(Sender: TObject);
begin
    AbreForm(TfrmcadProdutos, frmcadProdutos);
end;

procedure TfrmPrincipal.rptClientesClick(Sender: TObject);
begin
  AbreRpt(TRptRelClientes);
end;

procedure TfrmPrincipal.rptVendasPorClientesClick(Sender: TObject);
begin
  AbreRpt(TfrmRelatorioGVendasporCliente);
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.Vendas1Click(Sender: TObject);
begin
  AbreForm(TFrmPreVendas,FrmPreVendas);
end;

end.
