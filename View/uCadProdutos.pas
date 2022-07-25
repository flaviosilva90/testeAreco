unit uCadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, Data.DB, cxDBData, Vcl.StdCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ExtCtrls, System.Generics.Collections, uProdutoVO, uProdutoController, uDataModule;

type
  TfrmProdutos = class(TForm)
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridDBTableView1CODIGO_PRODUTO: TcxGridDBColumn;
    cxGridDBTableView1NOME_PRODUTO: TcxGridDBColumn;
    cxGridDBTableView1PRECO_PRODUTO: TcxGridDBColumn;
    cxGridDBTableView1ESTOQUE_PRODUTO: TcxGridDBColumn;
    cxGridDBTableView1CATEGORIA_PRODUTO: TcxGridDBColumn;
    cxGridDBTableView1SITUACAO_PRODUTO: TcxGridDBColumn;
    gbFormularioProdutos: TGroupBox;
    Label2: TLabel;
    edtCodigoProd: TEdit;
    btnAdd: TButton;
    edtNomeProd: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtPrecoProd: TEdit;
    edtEstoqueProd: TEdit;
    Label5: TLabel;
    rgCategoria: TRadioGroup;
    rgSituacao: TRadioGroup;
    btnGravar: TButton;
    BtnExcluir: TButton;
    procedure FormCreate(Sender: TObject);
    procedure edtPrecoProdKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cxGridDBTableView1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    ListaProduto : TObjectList<TProdutoVO>;
    vAcao : string;

    procedure LimpaTela;
    function GravarProduto(Acao : string) : boolean;
    function ChamaProcessoExclusao(CodigoProduto : string) : boolean;
  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

procedure TfrmProdutos.btnAddClick(Sender: TObject);
begin
  LimpaTela;
end;

procedure TfrmProdutos.BtnExcluirClick(Sender: TObject);
begin
  if (edtCodigoProd.Text = '') then
    MessageDlg('Selecione ao menos 1 produto para excluir.',mtWarning,[mbOK],0)
  else if not ChamaProcessoExclusao(edtCodigoProd.Text) then
    MessageDlg('Tivemos um problema ao tentar excluir. Tene novamente.',mtError,[mbOK],0);

  LimpaTela;
  TProdutoController.CarregaListaProdutos;
end;

procedure TfrmProdutos.btnGravarClick(Sender: TObject);
  function AnalisaCampos : boolean;
  begin
    Result := False;

    if (edtNomeProd.Text = '') then
    begin
      MessageDlg('Campo "Nome do Produto" � obrigat�rio.',mtWarning,[mbOK],0);
      Exit;
    end;

    if (edtPrecoProd.Text = '') then
    begin
      MessageDlg('Campo "Pre�o" � obrigat�rio.',mtWarning,[mbOK],0);
      Exit;
    end;

    if (strtofloat(edtPrecoProd.Text) <= 0) then
    begin
      MessageDlg('Campo "Pre�o" deve ser maior do que 0.',mtWarning,[mbOK],0);
      Exit;
    end;

    if (edtEstoqueProd.Text = '') then
    begin
      MessageDlg('Campo "Estoque" � obrigat�rio.',mtWarning,[mbOK],0);
      Exit;
    end;

    if rgCategoria.ItemIndex = -1 then
    begin
      MessageDlg('Campo "Categoria" � obrigat�rio.',mtWarning,[mbOK],0);
      Exit;
    end;

    if rgSituacao.ItemIndex = -1 then
    begin
      MessageDlg('Campo "Situa��o" � obrigat�rio.',mtWarning,[mbOK],0);
      Exit;
    end;

    Result := True;
  end;
begin

  if not AnalisaCampos then
    Exit;

  if edtCodigoProd.Text = '' then
    vAcao := 'Inserir'
  else
    vAcao := 'Editar';

  try
    if GravarProduto(vAcao) then
    begin
      MessageDlg('Grava��o Conclu�da!',mtInformation,[mbOK],0);
      LimpaTela;
      TProdutoController.CarregaListaProdutos;
    end
    else
    begin
      MessageDlg('OPS! Ocorreu um processo inesperado na grava��o, tente novamente.',mtError,[mbOK],0);
    end;
  except
    Exit;
  end;

end;

function TfrmProdutos.ChamaProcessoExclusao(CodigoProduto: string) : Boolean;
begin
  if MessageDlg('Tem certeza de que deseja excluir o produto de c�digo = '+edtCodigoProd.Text+'?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    Result := TProdutoController.ExcluiProduto(strtoint(CodigoProduto))
  else
  begin
    MessageDlg('Exclus�o Cancelada.',mtInformation,[mbOK],0);
    Result := True;
  end;
end;


procedure TfrmProdutos.cxGridDBTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  Categoria, Situacao : string;
begin
  edtCodigoProd.Text := VarAsType(cxGridDBTableView1.ViewData.Records
  [ACellViewInfo.gridRecord.index].Values[cxGridDBTableView1CODIGO_PRODUTO.Index],varstring);

  edtNomeProd.Text := VarAsType(cxGridDBTableView1.ViewData.Records
  [ACellViewInfo.gridRecord.index].Values[cxGridDBTableView1NOME_PRODUTO.Index],varstring);

  edtPrecoProd.Text := VarAsType(cxGridDBTableView1.ViewData.Records
  [ACellViewInfo.gridRecord.index].Values[cxGridDBTableView1PRECO_PRODUTO.Index],varstring);

  edtEstoqueProd.Text := VarAsType(cxGridDBTableView1.ViewData.Records
  [ACellViewInfo.gridRecord.index].Values[cxGridDBTableView1ESTOQUE_PRODUTO.Index],varstring);

  Categoria := VarAsType(cxGridDBTableView1.ViewData.Records
  [ACellViewInfo.gridRecord.index].Values[cxGridDBTableView1CATEGORIA_PRODUTO.Index],varstring);

  Situacao := VarAsType(cxGridDBTableView1.ViewData.Records
  [ACellViewInfo.gridRecord.index].Values[cxGridDBTableView1SITUACAO_PRODUTO.Index],varstring);

  if Situacao = 'A' then
    rgSituacao.ItemIndex := 0
  else
    rgSituacao.ItemIndex := 1;

  if Categoria = 'A' then rgCategoria.ItemIndex := 0
  else if Categoria = 'B' then rgCategoria.ItemIndex := 1
  else if Categoria = 'L' then rgCategoria.ItemIndex := 2
  else rgCategoria.ItemIndex := 3;

end;

procedure TfrmProdutos.edtPrecoProdKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',',',#8]) then
    key := #0;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  TProdutoController.CarregaListaProdutos;
end;

function TfrmProdutos.GravarProduto(Acao: string): boolean;
var
  Cont : integer;
begin
  Result := False;
  ListaProduto := TProdutoController.CriaListaProduto;
  Cont := 0;
  try
    ListaProduto.Add(TProdutoVO.Create);
    ListaProduto[Cont].NomeProd := edtNomeProd.Text;
    ListaProduto[Cont].PrecoProd  := StrToCurr(edtPrecoProd.Text);
    ListaProduto[Cont].EstoqueProd := strtoint(edtEstoqueProd.Text);

    case rgCategoria.ItemIndex of
      0 : ListaProduto[Cont].CategoriaProd := 'A';
      1 : ListaProduto[Cont].CategoriaProd := 'B';
      2 : ListaProduto[Cont].CategoriaProd := 'L';
      else
          ListaProduto[Cont].CategoriaProd := 'V';
    end;

    case rgSituacao.ItemIndex of
      0 : ListaProduto[Cont].SituacaoProd := 'A';
      else
          ListaProduto[Cont].SituacaoProd := 'I';
    end;

    if Acao = 'Inserir' then
      Result := TProdutoController.InsereProduto(ListaProduto)
    else
      Result := TProdutoController.EditaProduto(strtoint(edtCodigoProd.Text),ListaProduto);
  except
    Result := False;
  end;

end;

procedure TfrmProdutos.LimpaTela;
begin

 edtCodigoProd.Clear;
 edtNomeProd.Clear;
 edtPrecoProd.Clear;
 edtEstoqueProd.Clear;
 rgCategoria.ItemIndex := -1;
 rgSituacao.ItemIndex := -1;

 vAcao := '';

 if Assigned(ListaProduto) then
  begin
    try
      ListaProduto.Clear;
      FreeAndNil(ListaProduto);
    except
    end;
  end;

end;


end.
