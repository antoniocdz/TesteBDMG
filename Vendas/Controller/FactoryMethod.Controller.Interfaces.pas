unit FactoryMethod.Controller.Interfaces;

interface
uses
  Model.Concrete.Cliente, Model.Concrete.Produto,
  Model.Concrete.Fornecedor, Model.Concrete.PreVenda;

{Produtos}
type
  iController = interface
    ['{EAF3BA79-257A-4566-B1C2-5E7AFE2AA051}']
    function Entidades : iModelEntidadeFactory;
  end;
Type
  TController = class(TInterfacedObject, iController)
    private
      FModelEntidades : iModelEntidadeFactory;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iController;
      function Entidades : iModelEntidadeFactory;
  end;

 {Clientes}
 type
  iControllerCliente = interface
    ['{C3F817B6-8435-4D73-9B0B-DBF4CACA48FA}']
    function EntidadesCliente : iModelEntidadeClienteFactory;
end;

Type
  TControllerCliente = class(TInterfacedObject, iControllerCliente)
    private
      FModelEntidadesCliente : iModelEntidadeClienteFactory;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerCliente;
      function EntidadesCliente : iModelEntidadeClienteFactory;
  end;

 {Fornecedor}
 type
  iControllerFornecedor = interface
    ['{E5C469D0-44F8-4FEB-9EDF-9FEFBAB44DB6}']
    function EntidadesFornecedor : iModelEntidadeFornecedorFactory;
end;

Type
  TControllerFornecedor = class(TInterfacedObject, iControllerFornecedor)
    private
      FModelEntidadesFornecedor : iModelEntidadeFornecedorFactory;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerFornecedor;
      function EntidadesFornecedor : iModelEntidadeFornecedorFactory;
  end;

 {PreVenda}
 type
  iControllerPreVenda = interface
['{38260073-3A2D-48B7-8E57-78DBD52D2F83}']
    function EntidadesPreVenda : iModelEntidadePreVendaFactory;
end;

Type
  TControllerPreVenda = class(TInterfacedObject, iControllerPreVenda)
    private
      FModelEntidadesPreVenda : iModelEntidadePreVendaFactory;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerPreVenda;
      function EntidadesPreVenda : iModelEntidadePreVendaFactory;
  end;

implementation
{ TController Produtos }
constructor TController.Create;
begin
  FModelEntidades := TModelEntidadesFactory.New;
end;
destructor TController.Destroy;
begin
  inherited;
end;
function TController.Entidades: iModelEntidadeFactory;
begin
  Result := FModelEntidades;
end;
class function TController.New: iController;
begin
  Result := Self.Create;
end;
{ TControllerCliente }

constructor TControllerCliente.Create;
begin
    FModelEntidadesCliente := TModelEntidadesClienteFactory.New;
end;

destructor TControllerCliente.Destroy;
begin

  inherited;
end;

function TControllerCliente.EntidadesCliente: iModelEntidadeClienteFactory;
begin
    Result := FModelEntidadesCliente;
end;

class function TControllerCliente.New: iControllerCliente;
begin
  Result := Self.Create;
end;

{ TControllerFornecedor }

constructor TControllerFornecedor.Create;
begin
  FModelEntidadesFornecedor := TModelEntidadesFornecedorFactory.New;
end;

destructor TControllerFornecedor.Destroy;
begin

  inherited;
end;

function TControllerFornecedor.EntidadesFornecedor: iModelEntidadeFornecedorFactory;
begin
  Result := FModelEntidadesFornecedor;
end;

class function TControllerFornecedor.New: iControllerFornecedor;
begin
  Result := Self.Create;
end;

{ TControllerPreVenda }

constructor TControllerPreVenda.Create;
begin
  FModelEntidadesPreVenda := TModelEntidadesPreVendaFactory.New;
end;

destructor TControllerPreVenda.Destroy;
begin

  inherited;
end;

function TControllerPreVenda.EntidadesPreVenda: iModelEntidadePreVendaFactory;
begin
  Result := FModelEntidadesPreVenda;
end;

class function TControllerPreVenda.New: iControllerPreVenda;
begin
    Result := Self.Create;
end;

end.
