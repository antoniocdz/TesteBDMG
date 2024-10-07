unit Vendas.View.CadFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FCadastro, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Datasnap.DBClient,

  FactoryMethod.Controller.Interfaces, FEnum;

type
  TfrmcadFornecedores = class(Tfrmcadpadrao)
    edtrazaosocial: TLabeledEdit;
    rgStatus: TRadioGroup;
    edtCNPJ: TLabeledEdit;
    edtCodigo: TLabeledEdit;
    edtnomefantasia: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FControllerFornecedor : iControllerFornecedor;
    procedure Listagem(ACodigo: Integer; AIndiceAtual: string);
    function Gravar(StatusCadastro:TStatusCadastro): Boolean; override;
    function Excluir:Boolean; override;
    procedure Selects(ACodigo: Integer; AIndiceAtual: string); override;
  public
    { Public declarations }
  end;

var
  frmcadFornecedores: TfrmcadFornecedores;

implementation

{$R *.dfm}

{ TfrmcadFornecedores }

procedure TfrmcadFornecedores.btnAlterarClick(Sender: TObject);
begin
  if _Codigo > 0
  then
  begin
    Listagem(_Codigo, '');
    edtCodigo.Text:= IntToStr(_Codigo);
    edtrazaosocial.Text:= DsPadrao.DataSet.Fields[1].AsString;
    edtnomefantasia.Text:= DsPadrao.DataSet.Fields[2].AsString;
    edtCNPJ.Text:= getMascaraCNPJ(DsPadrao.DataSet.Fields[3].AsString);
    if DsPadrao.DataSet.Fields[4].AsString = 'Ativo'
     then
      rgStatus.ItemIndex := 0
    else
      rgStatus.ItemIndex := 1;
    inherited;
    edtrazaosocial.SetFocus;
  end
  else
  begin
    MessageDlg('Não há registros salvos.', mtInformation, [mbOK], 0);
    Exit;
  end;

end;

procedure TfrmcadFornecedores.btnCancelarClick(Sender: TObject);
begin
  Listagem(0,'');
  inherited;
end;

procedure TfrmcadFornecedores.btnExcluirClick(Sender: TObject);
begin
  if _Codigo = 0 then
  begin
    MessageDlg('Não há registros salvos.', mtInformation, [mbOK], 0);
    Exit;
  end
  else
    inherited;
end;

procedure TfrmcadFornecedores.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtrazaosocial.SetFocus;
end;

procedure TfrmcadFornecedores.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Listagem(999999999,_IndiceAtual);
end;

function TfrmcadFornecedores.Excluir: Boolean;
begin
  try
    if (StatusCadastro=ecExcluir)
     then
     begin
       if MessageDlg('Tem certeza que deseja excluir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
       then
       begin
         FControllerFornecedor := TControllerFornecedor.New;
         Result:= FControllerFornecedor
          .EntidadesFornecedor
           .Fornecedor
            .DataSet(DsPadrao)
             .ExecSql(_Codigo,'', '','','','ecExcluir');
          MessageDlg('Registro excluído com sucesso!', mtInformation, [mbOK], 0);
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

procedure TfrmcadFornecedores.FormCreate(Sender: TObject);
begin
  inherited;
  _FormFlagComponent:= 'N';
  _FormFlagPreVendas:= 0;
  Listagem(0,'');
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

procedure TfrmcadFornecedores.FormShow(Sender: TObject);
begin
  inherited;
  _IndiceAtual:= 'razao_social';
end;

function TfrmcadFornecedores.Gravar(StatusCadastro: TStatusCadastro): Boolean;
begin
  try
    FControllerFornecedor := TControllerFornecedor.New;
    if (StatusCadastro=ecInserir)
     then
     begin
       Result:= FControllerFornecedor
         .EntidadesFornecedor
          .Fornecedor
            .DataSet(DsPadrao)
             .ExecSql(0,Trim(edtrazaosocial.Text), Trim(edtnomefantasia.Text), getSomenteNumeros(edtCNPJ.Text), rgStatus.Items[rgStatus.ItemIndex],'ecInserir');
       if Result then MessageDlg('Registro salvo com sucesso!', mtInformation, [mbOK], 0);
     end
   else
   begin
     Result:= FControllerFornecedor
      .EntidadesFornecedor
       .Fornecedor
        .DataSet(DsPadrao)
         .ExecSql(StrToInt(trim(edtCodigo.Text)), Trim(edtrazaosocial.Text), Trim(edtnomefantasia.Text), getSomenteNumeros(edtCNPJ.Text), rgStatus.Items[rgStatus.ItemIndex],'ecAlterar');
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

procedure TfrmcadFornecedores.Listagem(ACodigo: Integer; AIndiceAtual: string);
begin
  FControllerFornecedor := TControllerFornecedor.New;
  if ACodigo < 999999999
   then
   begin
    FControllerFornecedor
    .EntidadesFornecedor
      .Fornecedor
        .DataSet(DsPadrao)
      .Open(ACodigo,'');
   end
   else
   begin
      FControllerFornecedor
      .EntidadesFornecedor
        .Fornecedor
          .DataSet(DsPadrao)
        .Open(ACodigo,Trim(mskPesquisa.Text));
   end;
end;

procedure TfrmcadFornecedores.Selects(ACodigo: Integer; AIndiceAtual: string);
begin
  inherited;
  if Trim(mskPesquisa.Text) = EmptyStr
   then
     Listagem(0,AIndiceAtual);
end;

end.
