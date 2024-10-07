unit Model.Concrete.Fornecedor;

interface

uses
  System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
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
    function ExecSQL(aSQL : String) : iModelQuery;
  end;
  iModelEntidadeFornecedor = interface
    function DataSet ( aValue : TDataSource ) : iModelEntidadeFornecedor;
    procedure Open(ACodigo: Integer;ANome: string);
    function ExecSql(Acodigoforn: Integer; Arazaosocial: string; Anomefantasia: string;
        Acnpjforn: string; Astatusforn: string; AStatus: string): Boolean;
  end;
  iModelEntidadeFornecedorFactory = interface
    function Fornecedor : iModelEntidadeFornecedor;
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
  TModelEntidadeFornecedor = class(TInterfacedObject, iModelEntidadeFornecedor)
    private
      FQuery : iModelQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEntidadeFornecedor;
      function DataSet ( aValue : TDataSource ) : iModelEntidadeFornecedor;
      procedure Open(ACodigo: Integer; ANome: string);
      function ExecSql(Acodigoforn: Integer; Arazaosocial: string; Anomefantasia: string;
        Acnpjforn: string; Astatusforn: string; AStatus: string): Boolean;
  end;
type
    TModelEntidadesFornecedorFactory = class(TInterfacedObject, iModelEntidadeFornecedorFactory)
    private
      FFornecedor : iModelEntidadeFornecedor;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEntidadeFornecedorFactory;
      function Fornecedor : iModelEntidadeFornecedor;
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
{ TModelEntidadeFornecedor }
constructor TModelEntidadeFornecedor.Create;
begin
  FQuery := TModelConexaoFactory.New.Query;
end;
function TModelEntidadeFornecedor.DataSet(aValue: TDataSource): iModelEntidadeFornecedor;
begin
  Result := Self;
  aValue.DataSet := TDataSet(FQuery.Query);
end;
destructor TModelEntidadeFornecedor.Destroy;
begin
  inherited;
end;
function TModelEntidadeFornecedor.ExecSql(Acodigoforn: Integer; Arazaosocial: string; Anomefantasia: string;
        Acnpjforn: string; Astatusforn: string; AStatus: string): Boolean;
var
  sSQL: string;
begin
  try
    case AnsiIndexStr(AStatus, ['ecInserir', 'ecAlterar','ecExcluir']) of
     0: begin
          sSQL:= 'INSERT INTO Fornecedores (razaosocialforn, nomefantasiaforn, cnpjforn, statusforn) ';
          sSQL:= sSQL + ' VALUES ( ' +
          QuotedStr(Arazaosocial) + ', ' +
          QuotedStr(Anomefantasia) + ', ' +
          QuotedStr(Acnpjforn) + ', ' +
          QuotedStr(Astatusforn) + ' )';
     end;
     1: begin
          sSQL:= 'UPDATE Fornecedores SET '
                  + ' razaosocialforn = '     + QuotedStr(Arazaosocial) + ', '
                  + ' nomefantasiaforn = '     + QuotedStr(Anomefantasia) + ', '
                  + ' cnpjforn   = '      + QuotedStr(Acnpjforn) + ', '
                  + ' statusforn = '      + QuotedStr(Astatusforn)

                  + ' where codigoforn = ' + IntToStr(Acodigoforn);

        end;
     2: sSQL:= 'DELETE FROM Fornecedores where codigoforn = ' + IntToStr(Acodigoforn);

    end;

    FQuery.ExecSQL(sSQL);
    Result:= True;
  except
    on E: Exception do
    begin
      Result:= False;
      raise Exception.CreateFmt('Erro: %s', [E.Message]);
    end;
  end;
end;

class function TModelEntidadeFornecedor.New: iModelEntidadeFornecedor;
begin
  Result := Self.Create;
end;
procedure TModelEntidadeFornecedor.Open(ACodigo: Integer;ANome: string);
var
  sSql : string;
begin
  try
    sSql:= 'Select codigoforn As Codigo' + ', '
           + 'razaosocialforn As Razao_Social' + ', '
           + 'nomefantasiaforn As Nome_Fantasia'    + ', '
           + 'cnpjforn As CNPJ'   + ', '
           + 'statusforn As Status';
           if ANome = EmptyStr
           then
           begin
             if ACodigo = 0 then
              sSql:= sSql + ' FROM Fornecedores order by razaosocialforn asc '
             else
              sSql:= sSql + ' FROM Fornecedores where codigoforn = ' + IntToStr(ACodigo);
           end
           else
             sSql:= sSql + ' FROM Fornecedores where codigoforn > 0 And (LOWER(razaosocialforn) LIKE ' + QuotedStr(ANome + '%') + ')';

    FQuery.Open(sSql);
    except
    on E: Exception do
      raise Exception.CreateFmt('Erro: %s', [E.Message]);

  end;
end;
{ TModelEntidadesFornecedorFactory }
constructor TModelEntidadesFornecedorFactory.Create;
begin
end;
destructor TModelEntidadesFornecedorFactory.Destroy;
begin
  inherited;
end;
class function TModelEntidadesFornecedorFactory.New: iModelEntidadeFornecedorFactory;
begin
  Result := Self.Create;
end;
function TModelEntidadesFornecedorFactory.Fornecedor: iModelEntidadeFornecedor;
begin
  if not Assigned(FFornecedor) then
    FFornecedor := TModelEntidadeFornecedor.New;
  Result := FFornecedor;
end;

end.
