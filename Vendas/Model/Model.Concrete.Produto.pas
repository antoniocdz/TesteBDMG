unit Model.Concrete.Produto;

interface

uses
  System.Classes,FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, System.SysUtils,FireDAC.DApt,
  Dao.ConexaoFactory.Interfaces;

type
  iModelQuery = interface;
  iModelConexao = interface
    function Connection : TObject;
  end;
  iModelConexaoFactory = interface
    function Conexao : iModelConexao;
    function Query : iModelQuery;
  end;
  iModelQuery = interface
    function Query : TObject;
    function Open(aSQL : String) : iModelQuery;
    function Lists(aSQL : String) : iModelQuery;
    function ExecSQL(aSQL : String) : iModelQuery;
  end;
  iModelEntidade = interface
    function DataSet ( aValue : TDataSource ) : iModelEntidade;
    procedure Open(ACodigo: Integer; ANome: string);
    procedure Lists(ACodigoLists: Integer);
    function ExecSql(codigoprod: Integer; Adescricaoprod: string;
             Aprecounitprod: Double; Afornprod: Integer; Astatusprod: string; AStatus: string): Boolean;
  end;
  iModelEntidadeFactory = interface
    function Produto : iModelEntidade;
  end;
Type
  TModelFiredacConexao = class(TInterfacedObject, iModelConexao)
    private
      FConexao : TFDConnection;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelConexao;
      function Connection : TObject;
  end;
Type
  TModelFiredacQuery = class(TInterfacedObject, iModelQuery)
    private
      FQuery : TFDQuery;
      FConexao : iModelConexao;
    public
      constructor Create(aValue : iModelConexao);
      destructor Destroy; override;
      class function New(aValue : iModelConexao) : iModelQuery;
      function Query : TObject;
      function Open(aSQL : String) : iModelQuery;
      function Lists(aSQL : String) : iModelQuery;
      function ExecSQL(aSQL : String) : iModelQuery;
  end;
Type
  TModelConexaoFactory = class(TInterfacedObject, iModelConexaoFactory)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelConexaoFactory;
      function Conexao : iModelConexao;
      function Query : iModelQuery;
  end;
Type
  TModelEntidadeProduto = class(TInterfacedObject, iModelEntidade)
    private
      FQuery : iModelQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEntidade;
      function DataSet ( aValue : TDataSource ) : iModelEntidade;
      procedure Open(ACodigo: Integer; ANome: string);
      procedure Lists(ACodigoLists: Integer);
      function ExecSql(Acodigoprod: Integer; Adescricaoprod: string;
               Aprecounitprod: Double; Afornprod: Integer; Astatusprod: string; AStatus: string): Boolean;
  end;
type
    TModelEntidadesFactory = class(TInterfacedObject, iModelEntidadeFactory)
    private
      FProduto : iModelEntidade;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEntidadeFactory;
      function Produto : iModelEntidade;
    end;
implementation

uses
  StrUtils;

{ TModelFiredacConexao }
function TModelFiredacConexao.Connection: TObject;
begin
  Result := FConexao;
end;
constructor TModelFiredacConexao.Create;
var
  MSSqlServerDriver : IConexaoFactory;
begin
  try
    MSSqlServerDriver := TSQLServerConexaoFactory.Create;
    FConexao := TFDConnection.Create(nil);

    FConexao := MSSqlServerDriver.Getconexao;
  except
    on E: Exception do
      raise Exception.CreateFmt('Erro: %s', [E.Message]);
  end;
end;
destructor TModelFiredacConexao.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;
class function TModelFiredacConexao.New: iModelConexao;
begin
  Result := Self.Create;
end;

{ TModelFiredacQuery }
constructor TModelFiredacQuery.Create(aValue: iModelConexao);
begin
  FConexao := aValue;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(FConexao.Connection);
end;
destructor TModelFiredacQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;
function TModelFiredacQuery.ExecSQL(aSQL: String): iModelQuery;
begin
  Result := Self;
  FQuery.ExecSQL(aSQL);
end;
function TModelFiredacQuery.Lists(aSQL: String): iModelQuery;
begin
  Result := Self;
  FQuery.Open(aSQL);
end;

class function TModelFiredacQuery.New(aValue: iModelConexao): iModelQuery;
begin
  Result := Self.Create(aValue);
end;
function TModelFiredacQuery.Open(aSQL: String): iModelQuery;
begin
  Result := Self;
  FQuery.Open(aSQL);
end;
function TModelFiredacQuery.Query: TObject;
begin
  Result := FQuery;
end;
{ TModelConexaoFactory }
function TModelConexaoFactory.Conexao: iModelConexao;
begin
  Result := TModelFiredacConexao.New;
end;
constructor TModelConexaoFactory.Create;
begin
end;
destructor TModelConexaoFactory.Destroy;
begin
  inherited;
end;
class function TModelConexaoFactory.New: iModelConexaoFactory;
begin
  Result := Self.Create;
end;
function TModelConexaoFactory.Query: iModelQuery;
begin
  Result := TModelFiredacQuery.New(Self.Conexao);
end;
{ TModelEntidadeProduto }
constructor TModelEntidadeProduto.Create;
begin
  FQuery := TModelConexaoFactory.New.Query;
end;
function TModelEntidadeProduto.DataSet(aValue: TDataSource): iModelEntidade;
begin
  Result := Self;
  aValue.DataSet := TDataSet(FQuery.Query);
end;
destructor TModelEntidadeProduto.Destroy;
begin
  inherited;
end;
function TModelEntidadeProduto.ExecSql(Acodigoprod: Integer; Adescricaoprod: string;
  Aprecounitprod: Double; Afornprod: Integer; Astatusprod: string; AStatus: string): Boolean;
var
  sSQL: string;
begin
  try
    case AnsiIndexStr(AStatus, ['ecInserir', 'ecAlterar','ecExcluir']) of
     0: begin
          sSQL:= 'INSERT INTO Produtos (descricaoProd, precounitProd, fornProd, statusProd ) ' +
                 ' VALUES ( ' +
                 QuotedStr(Adescricaoprod) + ', ' +
                 CurrToStr(Aprecounitprod) + ', ' +
                 IntToStr(Afornprod) + ', ' +
                 QuotedStr(Astatusprod) + ' )';
     end;
     1: begin
          sSQL:= 'UPDATE Produtos SET '
                  + ' descricaoprod = '    + QuotedStr(Adescricaoprod) + ', '
                  + ' precounitprod = '    + CurrToStr(Aprecounitprod) + ', '
                  + ' fornprod = '         + IntToStr(Afornprod) + ', '
                  + ' statusprod = '       + QuotedStr(Astatusprod)
                  + ' where codigoprod = ' + IntToStr(Acodigoprod);

        end;
     2: sSQL:= 'DELETE FROM Produtos where codigoprod = ' + IntToStr(Acodigoprod);

    end;

    FQuery.ExecSQL(sSQL);
    Result:= True;
  except
    on E: Exception do
    begin
      raise Exception.CreateFmt('Erro: %s', [E.Message]);
      Result:= False;
    end;
  end;
end;

procedure TModelEntidadeProduto.Lists(ACodigoLists: Integer);
var
  sSql : string;
begin
  try
    case ACodigoLists of
      0: begin
        sSql:= 'select F.CodigoForn as Codigo, F.razaosocialforn as Fornecedor ' +
        ' from fornecedores F where F.statusforn = ''Ativo'' ' +
        ' order by F.razaosocialforn asc';
      end;
      1: begin
           sSql:= 'Select P.codigoprod As Codigo'      + ', '
                   + 'P.descricaoprod As Descricao'      + ', '
                   + 'P.precounitprod As PrecoUnit'
                   + ' from Produtos P where P.statusprod = ''Ativo'' ';
      end;
    end;

    FQuery.Open(sSql);
    except
    on E: Exception do
      raise Exception.CreateFmt('Erro: %s', [E.Message]);
  end;

end;

class function TModelEntidadeProduto.New: iModelEntidade;
begin
  Result := Self.Create;
end;
procedure TModelEntidadeProduto.Open(ACodigo: Integer; ANome: string);
var
  sSql : string;
begin
  try
    sSql:= 'Select P.codigoprod As Codigo'      + ', '
           + 'P.descricaoprod As Descricao'      + ', '
           + 'P.precounitprod As Preco'  + ', '
           + 'F.razaosocialforn As Fornecedor'   + ', '
           + 'P.statusprod As Status'
           + ' FROM Produtos P '
           + ' INNER JOIN Fornecedores F ON (P.FornProd = F.CodigoForn ) ';
           if ANome = EmptyStr
           then
           begin
             if ACodigo > 0 then
               sSql:= sSql + ' where codigoprod = ' + IntToStr(ACodigo);
           end
           else
             sSql:= sSql + ' where codigoprod > 0 And (LOWER(P.descricaoprod) LIKE ' + QuotedStr(ANome + '%') + ')';

    FQuery.Open(sSql);
    except
    on E: Exception do
      raise Exception.CreateFmt('Erro: %s', [E.Message]);

  end;
end;

{ TModelEntidadesFactory }
constructor TModelEntidadesFactory.Create;
begin
end;
destructor TModelEntidadesFactory.Destroy;
begin
  inherited;
end;
class function TModelEntidadesFactory.New: iModelEntidadeFactory;
begin
  Result := Self.Create;
end;
function TModelEntidadesFactory.Produto: iModelEntidade;
begin
  if not Assigned(FProduto) then
    FProduto := TModelEntidadeProduto.New;
  Result := FProduto;
end;

end.
