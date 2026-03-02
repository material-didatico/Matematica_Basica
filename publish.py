#------------------------------------------------------------------------------#

from pathlib  import Path
from datetime import datetime
import shutil as sh

#------------------------------------------------------------------------------#

title      = 'Apostila de Matemática Básica'
discipline = 'Matemática Básica'
book_name  = 'MatematicaBasica.pdf'
add_book   = True

#------------------------------------------------------------------------------#

# Sources
root = Path(__file__).parent
book    = root / '1-book' / book_name
# classes = root / '2-classes' / 'pdf' / '2-hand'
# exams   = root / '3-exams'

# Destiny
page         = root / '_docs_md'
# page_classes = page / 'classes'
# page_exams   = page / 'exams'
index        = page / 'index.md'

tab = 4*' '

#------------------------------------------------------------------------------#
# def folder_name(src: str) -> str:
#     names = {
#             'A Introducao' : 'A - Introdução',
#             }
#     try:
#         return names[src]
#     except KeyError:
#         return src


#------------------------------------------------------------------------------#
def pdf_name(src: str) -> str:
    names = {
        'MatematicaBasica' : 'Matemática Básica'
    }

    try:
        return names[src]

    except KeyError:
        return src


#------------------------------------------------------------------------------#
def cp_pdf(src: str, dest: str) -> None:

    for pdf in src.glob("*/*.pdf"):
        dest_pdf = dest / pdf.relative_to(src)
        dest_pdf.parent.mkdir(parents=True, exist_ok=True)
        sh.copy2(pdf, dest_pdf)


#------------------------------------------------------------------------------#
def mk_page() -> None:

    print('Resetting page folders...')
    sh.rmtree(page, ignore_errors=True)
    page.mkdir()

    if add_book:
        print('Copying booklet...')
        sh.copy(book, page)

    # print('Copying handouts...')
    # cp_pdf(classes, page_classes)

    # print('Copying exams...')
    # cp_pdf(exams, page_exams)


#------------------------------------------------------------------------------#
def write_pdf_link(f, file: Path, prefix: str = ''):
    text = file.name.replace('_', ' ').replace('-', ' ').replace('.pdf', '')
    text = pdf_name(text)
    f.write(f'{prefix}[[PDF]]({file}) {text}\n')


#------------------------------------------------------------------------------#
def mk_index() -> None:
    with index.open("w", encoding="utf-8") as f:

        f.write(f"# {title}\n\n")
        f.write(datetime.now().strftime("Última atualização: %Y-%m-%d %H:%M:%S\n\n"))
        f.write(f"Materiais para a disciplina {discipline}\n\n")

        if add_book:

            f.write("\n??? Apostila\n")
            
            for file in sorted(page.glob("*.pdf")):
                write_pdf_link(f, file.relative_to(page), tab)

        # f.write('\n??? "Apresentações das aulas"\n')
        # 
        # for folder in sorted(page_classes.glob("*")):
        # 
        #     name = folder.name.replace('_', ' ').replace('-', ' ')
        #     name = folder_name(name)
        #     
        #     f.write(f'\n{tab}??? abstract "{name}"\n')
        #     
        #     for file in sorted(folder.glob("*.pdf")):
        #         write_pdf_link(f, file.relative_to(page), f'{tab}{tab}- ')

        # f.write('\n??? "Avaliações anteriores"\n')
        # 
        # for folder in sorted(page_exams.glob("*")):
        # 
        #     name = folder.name.replace('_', ' ').replace('-', ' ')
        #     
        #     f.write(f'\n{tab}??? abstract "{name}"\n')
        #     
        #     for file in sorted(folder.glob("*.pdf")):
        #         write_pdf_link(f, file.relative_to(page), f'{tab}{tab}- ')


#------------------------------------------------------------------------------#
if __name__ == '__main__':

    mk_page ()
    mk_index()

#------------------------------------------------------------------------------#
