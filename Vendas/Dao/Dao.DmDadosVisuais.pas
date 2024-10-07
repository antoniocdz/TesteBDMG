unit Dao.DmDadosVisuais;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmDadosVisuais = class(TDataModule)
    dtsItensVenda: TDataSource;
    fdmemItensVenda: TFDMemTable;
    fdmemItensVendaprodutoid: TIntegerField;
    fdmemItensVendanomeProduto: TStringField;
    fdmemItensVendaquantidade: TFloatField;
    fdmemItensVendavalorUnitario: TFloatField;
    fdmemItensVendavalorTotalProduto: TFloatField;
    fdmemItensVendaCancel: TFDMemTable;
    dsdtsItensVendaCancel: TDataSource;
    fdmemItensVendaCancelcancelprodutoid: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    _cdsModelVendas: TClientDataSet;
    procedure CriarModelVendas;
  public
    { Public declarations }
  end;

var
  DmDadosVisuais: TDmDadosVisuais;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmDadosVisuais }

procedure TDmDadosVisuais.CriarModelVendas;
begin
  fdmemItensVenda.Close;
  fdmemItensVenda.Open;
  fdmemItensVenda.EmptyDataSet;

  fdmemItensVendaCancel.Close;
  fdmemItensVendaCancel.Open;
  fdmemItensVendaCancel.EmptyDataSet;

end;

procedure TDmDadosVisuais.DataModuleCreate(Sender: TObject);
begin
  CriarModelVendas;
end;

procedure TDmDadosVisuais.DataModuleDestroy(Sender: TObject);
begin
  fdmemItensVenda.Close;
  fdmemItensVendaCancel.Close;
end;

end.
