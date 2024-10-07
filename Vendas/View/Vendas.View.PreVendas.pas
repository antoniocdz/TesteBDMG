unit Vendas.View.PreVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FCadastro, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, uCurrencyEditVCL, Dao.DmDadosVisuais,
  FactoryMethod.Controller.Interfaces, FEnum;

type
  TFrmPreVendas = class(Tfrmcadpadrao)
    dblcbListaCliente: TDBLookupComboBox;
    lbCliente: TLabel;
    edtNumVenda: TLabeledEdit;
    pnFundo: TPanel;
    pnDetailPreVenda: TPanel;
    pnFooterPreVenda: TPanel;
    pnHeaderPreVenda: TPanel;
    Label2: TLabel;
    edtTotallVenda: TCurrencyEdit;
    Label7: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    edtPrecoUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnAdicionarItem: TBitBtn;
    btnApagarItem: TBitBtn;
    dblcbProdutos: TDBLookupComboBox;
    Label3: TLabel;
    dbgridItensVenda: TDBGrid;
    TempoProcess: TTimer;
    edtDataVenda: TLabeledEdit;
    edtStatusVenda: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure TempoProcessTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure btnApagarItemClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dblcbProdutosClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    FControllerPreVenda   : iControllerPreVenda;
    FControllerProdutos   : iController;
    FControllerCliente    : iControllerCliente;
    FControllerFornecedor : iControllerFornecedor;

    dtmVendas: TDmDadosVisuais;

    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    function TotalizarVenda: Double;
    function StatusVenda(AStatus: string): Boolean;

    procedure Listagem(ACodigo: Integer; AIndiceAtual: string);
    procedure CarregarRegSelecionado;
    procedure ListaCliente(ACodigo: Integer);
    procedure LimparComponenteItem;
    procedure LimparCds;
    procedure PrecoUnitAtual;
    procedure VerificaStatusVendas(ACodigo: Integer; CodigoCliente: Integer);
    procedure SelectGenerics(ACodigo: Integer; ACodigoPesquisa: Integer);
    procedure PreencherItensVendas;
    function CancelarVendaAtual: Boolean;
    procedure Lista(ACodigo: Integer); override;
    function Gravar(StatusCadastro:TStatusCadastro): Boolean; override;
    Function Excluir:Boolean; override;
    procedure Selects(ACodigo: Integer; AIndiceAtual: string); override;

  public

  end;

var
  FrmPreVendas: TFrmPreVendas;

implementation

{$R *.dfm}

{ TFrmPreVendas }

procedure TFrmPreVendas.btnAdicionarItemClick(Sender: TObject);
begin
  inherited;
  if dblcbListaCliente.KeyValue=Null then
  begin
     MessageDlg('Cliente � um campo obrigat�rio' ,mtInformation,[mbOK],0);
     dblcbListaCliente.SetFocus;
     abort;
  end;

  if dblcbProdutos.KeyValue=Null then
  begin
     MessageDlg('Produto � um campo obrigat�rio' ,mtInformation,[mbOK],0);
     dblcbProdutos.SetFocus;
     abort;
  end;
  if edtPrecoUnitario.value<=0 then
  begin
     MessageDlg('Pre�o Unit�rio n�o pode ser Zero' ,mtInformation,[mbOK],0);
     edtPrecoUnitario.SetFocus;
     abort;
  end;
  if edtQuantidade.value<=0 then
  begin
     MessageDlg('Quantidade n�o pode ser Zero' ,mtInformation,[mbOK],0);
     edtQuantidade.SetFocus;
     abort;
  end;
  if dtmVendas.fdmemItensVenda.Locate('produtoId', dblcbProdutos.KeyValue, []) then
  begin
     MessageDlg('Este Produto j� foi selecionado' ,mtInformation,[mbOK],0);
     dblcbProdutos.SetFocus;
     abort;
  end;
  edtTotalProduto.Value:=TotalizarProduto(edtPrecoUnitario.Value, edtQuantidade.Value);
  dtmVendas.fdmemItensVenda.Append;
  dtmVendas.fdmemItensVenda.FieldByName('produtoId').AsString:=dblcbProdutos.KeyValue;
  dtmVendas.fdmemItensVenda.FieldByName('nomeProduto').AsString:= dblcbProdutos.Text;
  dtmVendas.fdmemItensVenda.FieldByName('quantidade').AsFloat:=edtQuantidade.Value;
  dtmVendas.fdmemItensVenda.FieldByName('valorUnitario').AsFloat:=edtPrecoUnitario.Value;
  dtmVendas.fdmemItensVenda.FieldByName('valorTotalProduto').AsFloat:=edtTotalProduto.Value;
  dtmVendas.fdmemItensVenda.Post;
  edtTotallVenda.Value:=TotalizarVenda;
  LimparComponenteItem;
  if not dbgridItensVenda.DataSource.DataSet.IsEmpty
  then
    dblcbListaCliente.Enabled:= False
  else
    dblcbListaCliente.Enabled:= True;
  dblcbProdutos.SetFocus;
end;

procedure TFrmPreVendas.btnAlterarClick(Sender: TObject);
var
i: Integer;
begin
  if _Codigo > 0
  then
  begin
    VerificaStatusVendas(0,_CodigoCliente);
    if StatusVenda(dsprevendas.DataSet.Fields[3].AsString)
     then
     begin
       MessageDlg('Venda n�o pode ser alterada, pois, j� esta Efetivada!', mtInformation, [mbOK], 0);
       Listagem(0,'');
      Abort;
     end
     else
     begin
       PreencherItensVendas;
       inherited;
       edtQuantidade.SetFocus;
     end;
  end
  else
  begin
    MessageDlg('N�o h� registros salvos.', mtInformation, [mbOK], 0);
    Abort;
  end;

end;

procedure TFrmPreVendas.btnApagarItemClick(Sender: TObject);
begin
  inherited;
  if dblcbProdutos.KeyValue=Null then
  begin
     MessageDlg('Selecione o Produto a ser exclu�do' ,mtInformation,[mbOK],0);
     dbgridItensVenda.SetFocus;
     abort;
  end;
  if dtmVendas.fdmemItensVenda.Locate('produtoId', dblcbProdutos.KeyValue, []) then begin
     dtmVendas.fdmemItensVenda.Delete;
     LimparComponenteItem;

     dbgridItensVenda.Refresh;
  end;
  edtTotallVenda.Value:=TotalizarVenda;
end;

procedure TFrmPreVendas.btnCancelarClick(Sender: TObject);
begin
  if  CancelarVendaAtual then
  begin
    Listagem(0,'');
    inherited;
    edtStatusVenda.Text:= 'Pendente';
  end
  else
    Abort;
end;

procedure TFrmPreVendas.btnExcluirClick(Sender: TObject);
begin
  if _Codigo > 0
  then
  begin
    VerificaStatusVendas(0,_CodigoCliente);
    if StatusVenda(dsprevendas.DataSet.Fields[3].AsString)
     then
     begin
       MessageDlg('Venda n�o pode ser exclu�da, pois, j� esta Efetivada!', mtInformation, [mbOK], 0);
       Listagem(0,'');
       Abort;
     end
     else
       inherited;
  end
  else
  begin
    MessageDlg('N�o h� registros salvos.', mtInformation, [mbOK], 0);
    Abort;
  end;

end;

procedure TFrmPreVendas.btnGravarClick(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja Efetivar a venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then
    begin
      edtStatusVenda.Text:= 'Efetivada';
    end
    else
      edtStatusVenda.Text:= 'Pendente';

  inherited;
end;

procedure TFrmPreVendas.btnNovoClick(Sender: TObject);
var
  vDescProduto: string;
begin
  inherited;
  dblcbListaCliente.Enabled:= True;
  ListaCliente(0);
  Lista(1);
  vDescProduto:= dsProdutos.DataSet.Fields[1].AsString;
  PrecoUnitAtual;
  edtQuantidade.Value:= 0.00;
  edtTotalProduto.Value:= 0.00;
  edtTotallVenda.Value:= 0.00;
  edtStatusVenda.Text:= 'Pendente';
  if dsProdutos.DataSet.Locate('Descricao', vDescProduto, []) then
    dblcbProdutos.KeyValue := dsProdutos.DataSet.Fields[0].AsInteger;

  LimparCds;
  dblcbListaCliente.SetFocus;
end;

procedure TFrmPreVendas.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Listagem(999999999,_IndiceAtual);
end;

function TFrmPreVendas.CancelarVendaAtual: Boolean;
begin
  if (StatusCadastro=ecInserir)
    or (StatusCadastro=ecAlterar)
  then
  begin
    if (not dtmVendas.fdmemItensVenda.IsEmpty)
      then
        if MessageDlg('Tem certeza que deseja cancelar a Venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
        then
          Result:= True
        else
          Result:= False;
  end;
end;

procedure TFrmPreVendas.CarregarRegSelecionado;
begin
  dblcbProdutos.KeyValue   := dtmVendas.fdmemItensVenda.FieldByName('produtoId').AsString;
  edtQuantidade.Value      := dtmVendas.fdmemItensVenda.FieldByName('quantidade').AsFloat;
  edtPrecoUnitario.Value   := dtmVendas.fdmemItensVenda.FieldByName('valorUnitario').AsFloat;
  edtTotalProduto.Value    := dtmVendas.fdmemItensVenda.FieldByName('valorTotalProduto').AsFloat;
end;

procedure TFrmPreVendas.dblcbProdutosClick(Sender: TObject);
begin
  inherited;
  PrecoUnitAtual;
end;

procedure TFrmPreVendas.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  if edtQuantidade.Value > 0
   then
     edtTotalProduto.Value:=TotalizarProduto(edtPrecoUnitario.Value, edtQuantidade.Value)
     else
       edtTotalProduto.Value:= 0.00;
end;

function TFrmPreVendas.Excluir: Boolean;
var
  vExecSqlOK: Boolean;
  vNumVenda : Integer;
begin
  try
    if (StatusCadastro=ecExcluir)
     then
     begin
       if MessageDlg('Tem certeza que deseja excluir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
       then
       begin
         vNumVenda:= dsprevendas.DataSet.Fields[0].AsInteger;

         vExecSqlOK:= FControllerPreVenda
           .EntidadesPreVenda
            .PreVenda
             .DataSet(dsprevendas)
              .ExecSql('VendasItens',vNumVenda, 0,0,0,nil,nil,'ecExcluir');

         if vExecSqlOK then
         begin
           Result:=  FControllerPreVenda
           .EntidadesPreVenda
            .PreVenda
             .DataSet(dsprevendas)
              .ExecSql('Vendas',vNumVenda, 0,0,0,nil,nil,'ecExcluir');
         end;
         if Result then MessageDlg('Registro exclu�do com sucesso!', mtInformation, [mbOK], 0);
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

procedure TFrmPreVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVendas) then
     FreeAndNil(dtmVendas);
end;

procedure TFrmPreVendas.FormCreate(Sender: TObject);
begin
  inherited;

  dtmVendas := TDmDadosVisuais.Create(self);
  _FormFlagComponent:= 'N';
  _FormFlagPreVendas:= 1;
  Listagem(0,'');
  if not grdListagem.DataSource.DataSet.IsEmpty
   then
   begin
     grdListagem.DataSource.DataSet.First;
     grdListagem.SelectedRows.CurrentRowSelected := True;
     _codigo := DsPadrao.DataSet.Fields[0].AsInteger;
     _CodigoCliente:= DsPadrao.DataSet.Fields[1].AsInteger;
   end
   else
   _codigo:= 0;
end;

procedure TFrmPreVendas.FormShow(Sender: TObject);
begin
  inherited;
  _IndiceAtual:= 'Nome';
end;

function TFrmPreVendas.Gravar(StatusCadastro: TStatusCadastro): Boolean;
var
 vExecSqlOK: Boolean;
 vNumVenda: Integer;
begin
  try
    FControllerPreVenda := TControllerPreVenda.New;
    if (StatusCadastro=ecInserir)
     then
     begin
       vExecSqlOK:= FControllerPreVenda
         .EntidadesPreVenda
          .PreVenda
            .DataSet(dsprevendas)
             .ExecSql('', 0, dblcbListaCliente.KeyValue,
                      StrToDateTime(edtDataVenda.Text),
                      FormatValor(edtTotallVenda.Value),
                      nil,nil,'ecInserir');

       if vExecSqlOK then
       begin
         FControllerPreVenda := TControllerPreVenda.New;
         FControllerPreVenda
           .EntidadesPreVenda
            .PreVenda
              .DataSet(dsprevendas)
               .OpenKeyGeneric(0);
         vNumVenda:= dsprevendas.DataSet.Fields[0].AsInteger;
       end;

       if vExecSqlOK then
       begin
         Result:= FControllerPreVenda
         .EntidadesPreVenda
          .PreVenda
            .DataSet(dsprevendas)
             .ExecSql(edtStatusVenda.Text, vNumVenda, 0, 0, 0.00,
                      dtmVendas.fdmemItensVenda,nil,'ecInserir');

       end;

       if Result then MessageDlg('Registro salvo com sucesso!', mtInformation, [mbOK], 0);
   end
   else
   begin
     Result:= FControllerPreVenda
     .EntidadesPreVenda
      .PreVenda
        .DataSet(dsprevendas)
         .ExecSql(edtStatusVenda.Text, StrToInt(edtNumVenda.Text), 0, 0, 0.00,
                      dtmVendas.fdmemItensVenda,dtmVendas.fdmemItensVendaCancel,'ecAlterar');

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

procedure TFrmPreVendas.LimparCds;
begin
  dtmVendas.fdmemItensVenda.First;
  while not dtmVendas.fdmemItensVenda.Eof do
    dtmVendas.fdmemItensVenda.Delete;

  if not dtmVendas.fdmemItensVendaCancel.IsEmpty
  then
  begin
    dtmVendas.fdmemItensVendaCancel.First;
    while not dtmVendas.fdmemItensVendaCancel.Eof do
      dtmVendas.fdmemItensVendaCancel.Delete;
  end;
end;

procedure TFrmPreVendas.LimparComponenteItem;
begin
  dblcbProdutos.KeyValue   := null;
  edtQuantidade.Value   := 0;
  edtPrecoUnitario.Value:= 0;
  edtTotalProduto.Value := 0;
end;

procedure TFrmPreVendas.Lista(ACodigo: Integer);
begin
  inherited;
  try
    FControllerProdutos := TController.New;
    case ACodigo of
      1: begin
           FControllerProdutos
            .Entidades
              .Produto
                .DataSet(dsProdutos)
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

procedure TFrmPreVendas.ListaCliente(ACodigo: Integer);
begin
  try
    FControllerPreVenda := TControllerPreVenda.New;
    case ACodigo of
      0: begin
           FControllerPreVenda
            .EntidadesPreVenda
              .PreVenda
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

procedure TFrmPreVendas.Listagem(ACodigo: Integer; AIndiceAtual: string);
begin
  FControllerPreVenda := TControllerPreVenda.New;
  if ACodigo < 999999999
   then
   begin
    FControllerPreVenda
    .EntidadesPreVenda
      .PreVenda
        .DataSet(DsPadrao)
      .Open(ACodigo,'');
   end
   else
   begin
      FControllerPreVenda
      .EntidadesPreVenda
        .PreVenda
          .DataSet(DsPadrao)
        .Open(ACodigo,Trim(mskPesquisa.Text));
   end;
end;

procedure TFrmPreVendas.PrecoUnitAtual;
begin
  edtPrecoUnitario.Text:= FormatFloat('###.00', dsProdutos.DataSet.Fields[2].AsFloat);
end;

procedure TFrmPreVendas.PreencherItensVendas;
var
  i: Integer;
begin
   i:= 1;
   edtStatusVenda.Text:= dsprevendas.DataSet.Fields[3].AsString;
   Listagem(_CodigoCliente, '');
   edtNumVenda.Text := dsPadrao.DataSet.Fields[0].AsString;

   Lista(1);
   dblcbProdutos.KeyValue := dsProdutos.DataSet.Fields[0].AsInteger;
   PrecoUnitAtual;
   edtQuantidade.Value:= 0.00;
   edtTotalProduto.Value:= 0.00;

   //Itens da Venda
   SelectGenerics(0,_CodigoCliente);
   LimparCds;

   dsprevendas.DataSet.First;
   while i <= dsprevendas.DataSet.RecordCount do
   begin
     dtmVendas.fdmemItensVenda.Append;
     dtmVendas.fdmemItensVenda.FieldByName('produtoId').AsString  := IntToStr(dsprevendas.DataSet.Fields[1].AsInteger);
     dtmVendas.fdmemItensVenda.FieldByName('nomeProduto').AsString:= dsprevendas.DataSet.Fields[2].AsString;
     dtmVendas.fdmemItensVenda.FieldByName('valorUnitario').AsFloat:=dsprevendas.DataSet.Fields[3].AsFloat;
     dtmVendas.fdmemItensVenda.FieldByName('quantidade').AsFloat:=dsprevendas.DataSet.Fields[4].AsFloat;
     dtmVendas.fdmemItensVenda.FieldByName('valorTotalProduto').AsFloat:=dsprevendas.DataSet.Fields[5].AsFloat;
     dtmVendas.fdmemItensVenda.Post;
     i:= i+ 1;
     dsprevendas.DataSet.Next;
   end;
   edtTotallVenda.Value:=TotalizarVenda;

   //Guarda os ItensVendas atuais, para serem verificados
   dtmVendas.fdmemItensVenda.First;
   while not dtmVendas.fdmemItensVenda.Eof do
   begin
     dtmVendas.fdmemItensVendaCancel.Append;
     dtmVendas.fdmemItensVendaCancel.FieldByName('cancelprodutoId').AsInteger  := StrToInt(dtmVendas.fdmemItensVenda.FieldByName('produtoId').AsString);
     dtmVendas.fdmemItensVendaCancel.Post;
     dtmVendas.fdmemItensVenda.Next;
   end;

   dtmVendas.fdmemItensVenda.First;
   ListaCliente(0);
   if dsaux.DataSet.Locate('Codigo', _CodigoCliente, []) then
     dblcbListaCliente.KeyValue := dsaux.DataSet.Fields[0].AsInteger;
   dblcbListaCliente.Enabled:=  False;

end;

procedure TFrmPreVendas.SelectGenerics(ACodigo, ACodigoPesquisa: Integer);
begin
  try
    FControllerPreVenda := TControllerPreVenda.New;
    case ACodigo of
      0: begin
           FControllerPreVenda
            .EntidadesPreVenda
              .PreVenda
                .DataSet(dsprevendas)
                 .SelectsGeneric(ACodigo, ACodigoPesquisa);
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

procedure TFrmPreVendas.Selects(ACodigo: Integer; AIndiceAtual: string);
begin
  inherited;
  if Trim(mskPesquisa.Text) = EmptyStr
   then
     Listagem(0,AIndiceAtual);
end;

function TFrmPreVendas.StatusVenda(AStatus: string): Boolean;
begin
  if AStatus = 'Efetivada' then Result:= True
   else
     Result:= False;
end;

procedure TFrmPreVendas.TempoProcessTimer(Sender: TObject);
begin
  inherited;
  edtDataVenda.Text:=  FormatDateTime('dd/mm/yyyy hh:MM:ss', Now);
end;

function TFrmPreVendas.TotalizarProduto(valorUnitario,
  Quantidade: Double): Double;
begin
  result :=valorUnitario * Quantidade;
end;

function TFrmPreVendas.TotalizarVenda: Double;
begin
  result:=0;
  dtmVendas.fdmemItensVenda.First;
  while not dtmVendas.fdmemItensVenda.Eof do begin
    result := result + dtmVendas.fdmemItensVenda.FieldByName('valorTotalProduto').AsFloat;
    dtmVendas.fdmemItensVenda.Next;
  end;
end;

procedure TFrmPreVendas.VerificaStatusVendas(ACodigo: Integer; CodigoCliente: Integer);
begin
  try
    FControllerPreVenda := TControllerPreVenda.New;
    case ACodigo of
      0: begin
           FControllerPreVenda
            .EntidadesPreVenda
              .PreVenda
                .DataSet(dsprevendas)
                 .StatusVenda(CodigoCliente, ACodigo);
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

end.
