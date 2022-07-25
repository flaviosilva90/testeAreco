program pTesteAreco;

uses
  Vcl.Forms,
  uDataModule in 'Data Module\uDataModule.pas' {Dtm: TDataModule},
  uProdutoVO in 'Model\uProdutoVO.pas',
  uCadProdutos in 'View\uCadProdutos.pas' {frmProdutos},
  uProdutoController in 'Controller\uProdutoController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDtm, Dtm);
  Application.CreateForm(TfrmProdutos, frmProdutos);
  Application.Run;
end.
