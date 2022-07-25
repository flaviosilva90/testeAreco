unit uProdutoController;

interface

uses  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
      System.Generics.Collections, uProdutoVO, uDataModule, Vcl.Dialogs;

type
  TProdutoController = class
  protected
  public
    class function CriaListaProduto: TObjectList<TProdutoVO>;
    class function InsereProduto(resp : TObjectList<TProdutoVO>) : boolean;
    class function EditaProduto (CodigoProd : integer; resp : TObjectList<TProdutoVO>) : boolean;
    class function ExcluiProduto (CodigoProd : integer) : boolean;
    class procedure CarregaListaProdutos;
  end;

implementation

{ TProdutoController }

class procedure TProdutoController.CarregaListaProdutos;
begin

  with uDataModule.Dtm do
  begin
    if adoquery.Active then
      adoquery.Close;

    adoquery.SQL.Clear;
    adoquery.SQL.Add('SELECT * FROM PRODUTOS_TESTEARECO ORDER BY CODIGO_PRODUTO');
    adoquery.Open;
  end;

end;

class function TProdutoController.CriaListaProduto: TObjectList<TProdutoVO>;
begin
  Result := TObjectList<TProdutoVO>.Create;
end;

class function TProdutoController.EditaProduto(
  CodigoProd : integer; resp: TObjectList<TProdutoVO>): boolean;
var
  I : integer;
begin
  Result := False;

  try
    with uDataModule.Dtm do
    begin
      for I := 0 to Pred(resp.Count) do
      begin
        ADOCommand.CommandText := 'UPDATE PRODUTOS_TESTEARECO SET '+
                                   ' NOME_PRODUTO = '+ quotedStr(resp[I].NomeProd)+','+
                                   ' PRECO_PRODUTO = '+ StringReplace(FloatToStr(resp[I].PrecoProd), ',', '.',[rfReplaceAll, rfIgnoreCase]) +','+
                                   ' ESTOQUE_PRODUTO = '+ inttostr(resp[I].EstoqueProd) +','+
                                   ' CATEGORIA_PRODUTO = '+ quotedStr(resp[I].CategoriaProd) +','+
                                   ' SITUACAO_PRODUTO = '+ quotedStr(resp[I].SituacaoProd) +
                                   ' WHERE CODIGO_PRODUTO = '+ IntToStr(CodigoProd);
        ADOCommand.Execute;
        Result := True;
      end;
    end;
  except on E:Exception do
    begin
      Result := False;
      MessageDlg(E.Message,mtError,[mbOk],0);
    end;
  end;
end;


class function TProdutoController.ExcluiProduto(CodigoProd: integer): boolean;
begin
  try
    with uDataModule.Dtm do
    begin
      ADOCommand.CommandText := 'DELETE PRODUTOS_TESTEARECO '+
                                ' WHERE CODIGO_PRODUTO = '+ IntToStr(CodigoProd);
      ADOCommand.Execute;
      Result := True;
    end;
  except on E:Exception do
    begin
      Result := False;
      MessageDlg(E.Message,mtError,[mbOk],0);
    end;
  end;
end;

class function TProdutoController.InsereProduto(
  resp: TObjectList<TProdutoVO>): boolean;
var
  I : integer;
begin
  Result := False;

  try
    with uDataModule.Dtm do
    begin
      for I := 0 to Pred(resp.Count) do
      begin
        ADOCommand.CommandText := 'INSERT INTO PRODUTOS_TESTEARECO VALUES ('+
                                    quotedStr(resp[I].NomeProd)+', '+
                                    StringReplace(FloatToStr(resp[I].PrecoProd), ',', '.',[rfReplaceAll, rfIgnoreCase]) +', '+
                                    inttostr(resp[I].EstoqueProd) +', '+
                                    quotedStr(resp[I].CategoriaProd) +', '+
                                    quotedStr(resp[I].SituacaoProd) +' )';
        ADOCommand.Execute;
        Result := True;
      end;
    end;
  except on E:Exception do
    begin
      Result := False;
      MessageDlg(E.Message,mtError,[mbOk],0);
    end;
  end;
end;


end.
