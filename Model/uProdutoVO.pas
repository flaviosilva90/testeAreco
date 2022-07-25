unit uProdutoVO;

interface

uses
  SysUtils, Generics.Collections;

type
  TProdutoVO = class
  private
    FNomeProd      : String;
    FPrecoProd     : Currency;
    FEstoqueProd   : integer;
    FCategoriaProd : string;
    FSituacaoProd  : string;

  public
    property NomeProd     : string       read FNomeProd       write FNomeProd;
    property PrecoProd    : Currency     read FPrecoProd      write FPrecoProd;
    property EstoqueProd  : integer      read FEstoqueProd    write FEstoqueProd;
    property CategoriaProd: string       read FCategoriaProd  write FCategoriaProd;
    property SituacaoProd : string       read FSituacaoProd   write FSituacaoProd;
  end;

implementation

{ TProdutoVO }

initialization

end.

