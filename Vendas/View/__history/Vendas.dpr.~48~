program Vendas;



uses
  Vcl.Forms,
  Vendas.View.Principal in 'Vendas.View.Principal.pas' {frmPrincipal},
  FCadastro in '..\INFRA\PadraoForms\FCadastro.pas' {frmcadpadrao},
  Dao.ConexaoFactory.Interfaces in '..\Dao\Dao.ConexaoFactory.Interfaces.pas',
  FactoryMethod.Controller.Interfaces in '..\Controller\FactoryMethod.Controller.Interfaces.pas',
  Model.Concrete.Produto in '..\Model\Model.Concrete.Produto.pas',
  Model.Concrete.Cliente in '..\Model\Model.Concrete.Cliente.pas',
  Vendas.View.CadClientes in 'Vendas.View.CadClientes.pas' {frmcadClientes},
  Vendas.View.CadFornecedores in 'Vendas.View.CadFornecedores.pas' {frmcadFornecedores},
  Vendas.View.CadProdutos in 'Vendas.View.CadProdutos.pas' {frmcadProdutos},
  FEnum in '..\INFRA\PadraoForms\FEnum.pas',
  Model.Concrete.Fornecedor in '..\Model\Model.Concrete.Fornecedor.pas',
  RRelatorio in '..\INFRA\PadraoRpts\RRelatorio.pas' {RptRelatorio},
  RptClientes in '..\Report\RptClientes.pas' {RptRelClientes},
  Vendas.View.PreVendas in 'Vendas.View.PreVendas.pas' {FrmPreVendas},
  Enter in '..\INFRA\Components\Terceiros\Teclas\Enter.pas',
  Model.Concrete.PreVenda in '..\Model\Model.Concrete.PreVenda.pas',
  Dao.DmDadosVisuais in '..\Dao\Dao.DmDadosVisuais.pas' {DmDadosVisuais: TDataModule},
  RptVendasPorClientes in '..\Report\RptVendasPorClientes.pas' {RptVendasporCli};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TRptVendasporCli, RptVendasporCli);
  //Application.CreateForm(Tfrmcadpadrao, frmcadpadrao);
  Application.Run;
end.
