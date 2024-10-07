unit Vendas.View.CadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FCadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ExtCtrls,

  FactoryMethod.Controller.Interfaces, FEnum,
  Datasnap.DBClient, uCurrencyEditVCL;

type
  TfrmcadProdutos = class(Tfrmcadpadrao)
    rgStatus: TRadioGroup;
    edtdescricaoprod: TLabeledEdit;
    edtCodigo: TLabeledEdit;
    dblcbListaForn: TDBLookupComboBox;
    lbFornecedor: TLabel;
    edtPrecoUnitario: TCurrencyEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FController        : iController;
    procedure Listagem(ACodigo: Integer; AIndiceAtual: string);
    function Gravar(StatusCadastro:TStatusCadastro): Boolean; override;
    function Excluir:Boolean; override;
    procedure Selects(ACodigo: Integer; AIndiceAtual: string); override;
    procedure Lista(ACodigo: Integer); override;


  public
    { Public declarations }
  end;

var
  frmcadProdutos: TfrmcadProdutos;

implementation

{$R *.dfm}

{ TfrmcadProdutos }

procedure TfrmcadProdutos.btnAlterarClick(Sender: TObject);
var
  vForn: string;
begin
  if _Codigo > 0
  then
  begin
    Listagem(_Codigo, '');
    edtCodigo.Text:= IntToStr(_Codigo);
    edtdescricaoprod.Text:= DsPadrao.DataSet.Fields[1].AsString;
    edtPrecoUnitario.Text:= FormatFloat('###.00', DsPadrao.DataSet.Fields[2].AsFloat);
    vForn:= DsPadrao.DataSet.Fields[3].AsString;
    if DsPadrao.DataSet.Fields[4].AsString = 'Ativo'
     then
      rgStatus.ItemIndex := 0
    else
      rgStatus.ItemIndex := 1;

    Lista(0);
    if dsaux.DataSet.Locate('Fornecedor', vForn, []) then
      dblcbListaForn.KeyValue := dsaux.DataSet.Fields[0].AsInteger;

    inherited;
    edtdescricaoprod.SetFocus;
  end
  else
  begin
    MessageDlg('N�o h� registros salvos.', mtInformation, [mbOK], 0);
    Exit;
  end;
end;

procedure TfrmcadProdutos.btnCancelarClick(Sender: TObject);
begin
  Listagem(0,'');
  inherited;
end;

procedure TfrmcadProdutos.btnExcluirClick(Sender: TObject);
begin
  if _Codigo = 0 then
  begin
    MessageDlg('N�o h� registros salvos.', mtInformation, [mbOK], 0);
    Exit;
  end
  else
    inherited;
end;

procedure TfrmcadProdutos.btnNovoClick(Sender: TObject);
begin
  inherited;
  Lista(0);
  edtdescricaoprod.SetFocus;
end;

procedure TfrmcadProdutos.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Listagem(999999999,_IndiceAtual);
end;

function TfrmcadProdutos.Excluir: Boolean;
begin
  try
    if (StatusCadastro=ecExcluir)
     then
     begin
       if MessageDlg('Tem certeza que deseja excluir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
       then
       begin
         FController := TController.New;
         Result:= FController
          .Entidades
           .Produto
            .DataSet(DsPadrao)
             .ExecSql(_Codigo,'', 0,0,'','ecExcluir');
          MessageDlg('Registro exclu�do com sucesso!', mtInformation, [mbOK], 0);
       end
       else
         Result:= False;
     end;
     Listagem(0,'');
  except
     On E : Exception Do
     begin
       MessageDlg('Erro: ' + E.Message, mtError, [mbOK], 0);
       Exit;
     end;
  end;

end;

procedure TfrmcadProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  Listagem(0,'');
  _FormFlagComponent:= 'S';
  _FormFlagPreVendas:= 0;
  if not grdListagem.DataSource.DataSet.IsEmpty
   then
   begin
     grdListagem.DataSource.DataSet.First;
     grdListagem.SelectedRows.CurrentRowSelected := True;
     _codigo := DsPadrao.DataSet.Fields[0].AsInteger;
   end
   else
   _codigo:= 0;

end;

procedure TfrmcadProdutos.FormShow(Sender: TObject);
begin
  inherited;
  _IndiceAtual:= 'Descricao';
end;

function TfrmcadProdutos.Gravar(StatusCadastro: TStatusCadastro): Boolean;
begin
  try
    FController := TController.New;
    if (StatusCadastro=ecInserir)
     then
     begin
       Result:= FController
         .Entidades
          .Produto
            .DataSet(DsPadrao)
             .ExecSql(0, edtdescricaoprod.Text, FormatValor(edtPrecoUnitario.Value), dblcbListaForn.KeyValue, rgStatus.Items[rgStatus.ItemIndex], 'ecInserir');
       if Result then MessageDlg('Registro salvo com sucesso!', mtInformation, [mbOK], 0);
     end
   else
   begin
     Result:= FController
      .Entidades
       .Produto
        .DataSet(DsPadrao)
         .ExecSql(StrToInt(trim(edtCodigo.Text)),Trim(edtdescricaoprod.Text), FormatValor(edtPrecoUnitario.Value), dblcbListaForn.KeyValue, rgStatus.Items[rgStatus.ItemIndex], 'ecAlterar');
     if Result then MessageDlg('Registro atualizado com sucesso!', mtInformation, [mbOK], 0);
   end;
   Listagem(0,'');
  except
     On E : Exception Do
     begin
       MessageDlg('Erro: ' + E.Message, mtError, [mbOK], 0);
       Exit;
     end;
  end;

end;

procedure TfrmcadProdutos.Lista(ACodigo: Integer);
begin
  inherited;
  try
    FController := TController.New;
    case ACodigo of
      0: begin
           FController
            .Entidades
              .Produto
                .DataSet(dsaux)
                 .Lists(ACodigo);
      end;
    end;
  except
     On E : Exception Do
     begin
       MessageDlg('Erro: ' + E.Message, mtError, [mbOK], 0);
       Exit;
     end;
  end;

end;

procedure TfrmcadProdutos.Listagem(ACodigo: Integer; AIndiceAtual: string);
begin
  FController := TController.New;
  if ACodigo < 999999999
   then
   begin
    FController
    .Entidades
      .Produto
        .DataSet(DsPadrao)
      .Open(ACodigo,'');
   end
   else
   begin
      FController
      .Entidades
        .Produto
          .DataSet(DsPadrao)
        .Open(ACodigo,Trim(mskPesquisa.Text));
   end;
end;

procedure TfrmcadProdutos.Selects(ACodigo: Integer; AIndiceAtual: string);
begin
  inherited;
  if Trim(mskPesquisa.Text) = EmptyStr
   then
     Listagem(0,AIndiceAtual);
end;

end.
