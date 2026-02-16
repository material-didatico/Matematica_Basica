%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
%
% LaTeX Class for Nice Classroom Notes
%
% Luis A. D'Afonseca
%
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nice-booklet}[2025/09/02 A Nice Booklet LaTeX Class]

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Package Options
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

% Add extra functionalities
\RequirePackage{etoolbox}
\RequirePackage{xpatch}
\RequirePackage{kvoptions}

\SetupKeyvalOptions{
  family=nicebooklet,
  prefix=nicebooklet@
}

\DeclareBoolOption{draft}
\DeclareBoolOption{fast}
\DeclareComplementaryOption{final}{draft}

\DeclareStringOption[]{cc}[by-sa]

\DeclareDefaultOption{%
  \ClassWarningNoLine{Nice Booklet}{Unknown option `\CurrentOption’}
}

\ProcessKeyvalOptions*

\newcommand{\@TextMode}{}
\newbool{FastMode}
\boolfalse{FastMode}

\ifnicebooklet@draft
  \renewcommand{\@TextMode}{draft}
  \booltrue{FastMode}
\fi

\ifnicebooklet@fast
  \booltrue{FastMode}
\fi

% Load base class: extbook
\LoadClass[14pt,
           notitlepage,
           oneside,
           openany,
           \@TextMode]{extbook}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Packages to pt_BR localization
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage{cmap}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english,brazil]{babel}
\RequirePackage{indentfirst}
\RequirePackage{icomma}
\RequirePackage{csquotes}

% Packages to add fonts and fix typesetting
%------------------------------------------------------------------------------%

\RequirePackage{ae}
\RequirePackage{fontenc}
\RequirePackage{microtype}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Color palette
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage[table,fixpdftex,hyperref]{xcolor}

% Cover
\definecolor{cpCoverDefaultBackgound}{HTML}{e0e0ff}
\definecolor{cpCoverAuthor}          {HTML}{0f3057}
\definecolor{cpCoverTitle}           {HTML}{0f3057}
\definecolor{cpCoverBelt}            {gray}{0.99}
\newcommand{\BeltOpacity}{1}
\newlength{\BeltPosition}
\setlength{\BeltPosition}{35mm}

% Titles
\definecolor{cpTitlePart}   {HTML}{0f3057}
\definecolor{cpPartElements}{HTML}{e0e0ff}
\definecolor{cpTitleChapter}{HTML}{0f3057}
\definecolor{cpTitleSection}{HTML}{0f3057}

% Lists enphasis and observation
\definecolor{cpListItens}       {HTML}{eb5e0b}
\definecolor{cpEmph}            {HTML}{eb5e0b}
\definecolor{cpBoxEmphasisFrame}{HTML}{e0e0ff}
\definecolor{cpBoxEmphasisBack} {gray}{0.99}
\definecolor{cpBoxObsFrame}     {HTML}{ffe8e8}
\definecolor{cpBoxObsBack}      {HTML}{ffe8e8}

% Theory and Theorem Boxes
\definecolor{cpBoxTheoryFrame}    {HTML}{bbbbf2}
\definecolor{cpBoxTheoryTitleBack}{HTML}{bbbbf2}
\definecolor{cpBoxTheoryBack}     {HTML}{e0e0ff}
\definecolor{cpBoxTheoryTitle}    {gray}{0}
\definecolor{cpBoxProofFrame}     {gray}{0.92}
\definecolor{cpBoxProofBack}      {gray}{0.99}

% Example Boxes
\definecolor{cpBoxExampleFrame}   {HTML}{ededc4}
\definecolor{cpBoxExampleTitle}   {HTML}{393398}
\definecolor{cpBoxExampleQuestion}{HTML}{393398}
\definecolor{cpBoxExampleBack}    {HTML}{fffff5}
\definecolor{cpBoxExampleLines}   {HTML}{f9f9eb}

% Tables
\definecolor{cpBoxTableTitleBack}{HTML}{bbbbf2}
\definecolor{cpBoxTableTitle}    {gray}{0}
\definecolor{cpBoxTableFrame}    {HTML}{bbbbf2}

% Links and Online Boxes
\definecolor{cpLinks}          {HTML}{008891}
\definecolor{cpBoxOnlineFrame} {HTML}{008891}
\definecolor{cpBoxOnlineBack}  {HTML}{f0f5f5}
\definecolor{cpBoxOnlineQR}    {gray}{0}
\definecolor{cpBoxOnlineQRBack}{gray}{1}

% Page colors
\definecolor{cpPageHeader}    {gray}{0.5}
\definecolor{cpPageBackground}{gray}{0.99}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Text formatting
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage[nodisplayskipstretch]{setspace}
\RequirePackage{tabto}

\renewcommand{\baselinestretch}{1.1}

\renewcommand{\emph}[1]{\textcolor{cpEmph}{#1}}

\setlength{\parskip}{7mm plus 3mm minus 2mm}
\setlength{\parindent}{0pt}

\raggedbottom

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Index creation
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\ifbool{FastMode}
{
  \newcommand{\printindex}
  {%
    \chapter*{Índice Remissivo}%
    \label{cap:indice_remissivo}%
    \addcontentsline{toc}{chapter}{Índice Remissivo}
  }
}{
  \RequirePackage{imakeidx}

  \makeindex[columns=3,intoc]

  \indexsetup{othercode={%
    \label{cap:indice_remissivo}%
    \small%
  }}
}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Math packages and definitions
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage[fleqn]{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}

\allowdisplaybreaks

\newlength{\defaultMathIndent}
\setlength{\defaultMathIndent}{2em}
\setlength{\mathindent}{1\defaultMathIndent}
\renewcommand*{\arraystretch}{1.2}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Bibliography
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

% Bibliography using biblatex
%------------------------------------------------------------------------------%

\RequirePackage[backend=biber,%
                ittitles,%
                giveninits=true,%
                justify,%
                indent,%
                scbib,%
                repeatfields,%
                comp,%
                noslsn,%
                natbib=true,%
                style=abnt-numeric]{biblatex}

\AtEveryCite{%
  \let\parentext=\parentexttrack%
  \let\bibopenparen=\bibopenbracket%
  \let\bibcloseparen=\bibclosebracket}

\renewcommand*{\bibfont}{\small}
\appto{\bibsetup}{\sloppy}

\let\oldprintbibliography\printbibliography

\renewcommand{\printbibliography}{
  \begingroup
  \setstretch{0.9}
  \oldprintbibliography[title=Referências,heading=bibintoc]
  \endgroup
}

\renewrobustcmd*{\mkbibemph}{\mkbibitalic}
\protected\long\def\blx@imc@mkbibemph#1{\blx@imc@mkbibitalic{#1}}

\AtBeginBibliography{\vspace{-2\baselineskip}}

\renewcommand{\textcite}[2][]{\citeauthor{#2} \cite[#1]{#2}}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Figures Packages and configuration
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage{graphicx}

% To improve floats positioning
\def\fps@figure{htbp}
\def\fps@table {htbp}

\setcounter{topnumber}   {4}
\setcounter{bottomnumber}{4}
\setcounter{totalnumber}{10}

\renewcommand{\textfraction}     {0.15}
\renewcommand{\topfraction}      {0.85}
\renewcommand{\bottomfraction}   {0.70}
\renewcommand{\floatpagefraction}{0.66}

\setcounter   {dbltopnumber}           {2}
\renewcommand*{\dbltopfraction}        {1}
\renewcommand*{\dblfloatpagefraction}{0.9}

\NewDocumentCommand{\IncludeGraphic}{m O{1}}%
{%
  \par%
  \includegraphics[width=#2\linewidth]{#1}%
  \par%
}

\NewDocumentCommand{\IncludeGraphicEx}{m O{1}}%
{%
  \par%
  \fcolorbox{cpBoxExampleLines}{cpBoxExampleBack}%
    {\includegraphics[width=#2\linewidth]{#1}}%
  \par%
}

\NewDocumentCommand{\IncludeGraphicHeight}{m m O{0} O{0}}%
{%
  \par%
  \vspace{#3\baselineskip}%
  \includegraphics[height=#2]{#1}%
  \vspace{#4\baselineskip}%
  \par%
}

\NewDocumentCommand{\IncludeGraphicHeightEx}{m m O{0} O{0}}%
{%
  \par%
  \vspace{#3\baselineskip}%
  \fcolorbox{cpBoxExampleLines}{cpBoxExampleBack}%
    {\includegraphics[height=#2]{#1}}%
  \vspace{#4\baselineskip}%
  \par%
}

\NewDocumentCommand{\IncludeGraphicCentred}{ m O{0.9} O{0} O{0} }%
{%
  \begin{center}%
    \vspace{#3\baselineskip}%
    \includegraphics[width=#2\columnwidth]{#1}%
    \vspace{#4\baselineskip}%
  \end{center}%
}

\NewDocumentCommand{\IncludeGraphicCentredEx}{ m O{0.9} O{0} O{0} }%
{%
  \begin{center}%
    \vspace{#3\baselineskip}%
    \fcolorbox{cpBoxExampleLines}{cpBoxExampleBack}%
      {\includegraphics[width=#2\columnwidth]{#1}}%
    \vspace{#4\baselineskip}%
  \end{center}%
}

\NewDocumentCommand{\IncludeTexGraphicCentred}{m O{0} O{0}}%
{%
  \begin{center}%
    \vspace{#2\baselineskip}%
    \input{#1}%
    \vspace{#3\baselineskip}%
  \end{center}%
}

\NewDocumentCommand{\IncludeTexGraphicCentredEx}{m O{0} O{0}}%
{%
  \begin{center}%
    \vspace{#2\baselineskip}%
    \fcolorbox{cpBoxExampleLines}{cpBoxExampleBack}{\input{#1}}%
    \vspace{#3\baselineskip}%
  \end{center}%
}

% Keep floats on the same section
\RequirePackage[section,above,below]{placeins}

% Caption configuration options
\RequirePackage[width=0.96\linewidth,justification=centerlast,labelfont=bf]{caption}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Create hyperlinks
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage{hyperref}

\urlstyle{sf}

\hypersetup{%
  colorlinks = true,
  linkcolor  = cpLinks,
  urlcolor   = cpLinks,
  citecolor  = cpLinks
}

\newcommand{\wiki}[2]{%
  \href{#1}{#2\,\raisebox{-0.2ex}{\includegraphics[height=1.8ex]{wikipedia-logo}}}%
}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Box Environments
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage{tcolorbox}

\tcbuselibrary{breakable,skins,theorems,xparse}

% Common options
\tcbset{
  skin      = enhanced,
  arc       = 2pt,
  parbox    = false,
  breakable = true,
  beforeafter skip balanced = \baselineskip,
}

% Theory and Theorems
%------------------------------------------------------------------------------%

% Theory options
\tcbset{theoryBox/.style={
  minipage boxed title,
  attach boxed title to top left={%
    yshift = -1mm,
  },
  boxed title style = {%
    colback   = cpBoxTheoryTitleBack,
    colframe  = cpBoxTheoryFrame,
    sharp corners  = southwest,
  },
  colback   = cpBoxTheoryBack,
  colframe  = cpBoxTheoryBack,
  coltitle  = cpBoxTheoryTitle,
  fonttitle = \scshape,
}}

% Theory environment
\NewTColorBox{theory}{!o}{%
  theoryBox,
  IfNoValueTF={#1}{}{%
    adjusted title = {#1},
    sharp corners  = northwest,
  }
}

% Theorem options
\tcbset{theoremBox/.style={
  theoryBox,
  label separator = {},
  sharp corners   = northwest,
}}

% Theorems
\newtcbtheorem[number within=chapter                         ]{axioma}    {\strut{}Axioma}    {theoremBox}{}
\newtcbtheorem[number within=chapter, use counter from=axioma]{definicao} {\strut{}Definição} {theoremBox}{}
\newtcbtheorem[number within=chapter, use counter from=axioma]{postulado} {\strut{}Postulado} {theoremBox}{}
\newtcbtheorem[number within=chapter, use counter from=axioma]{proposicao}{\strut{}Proposição}{theoremBox}{}
\newtcbtheorem[number within=chapter, use counter from=axioma]{lema}      {\strut{}Lema}      {theoremBox}{}
\newtcbtheorem[number within=chapter, use counter from=axioma]{teorema}   {\strut{}Teorema}   {theoremBox}{}
\newtcbtheorem[number within=chapter, use counter from=axioma]{corolario} {\strut{}Corolário} {theoremBox}{}

% Proof environment
\RenewDocumentEnvironment{proof}{o}{%
  \emph{\proofname\IfNoValueTF{#1}{}{: #1}}\\[0.3\baselineskip]
}
{}

\tcolorboxenvironment{proof}{%
  skin     = enhancedmiddle,
  boxrule  = 0mm,
  leftrule = 2mm,
  colframe = cpBoxProofFrame,
  colback  = cpBoxProofBack,
}

% Observation and examples
%------------------------------------------------------------------------------%

% Observations environment
\newtcolorbox{observation}{
  colback  = cpBoxObsBack,
  colframe = cpBoxObsFrame,
}

% Emphasis
\newtcolorbox{emphasis}{%
  skin     = enhancedmiddle,
  boxrule  = 0mm,
  leftrule = 1.5mm,
  colframe = cpBoxEmphasisFrame,
  colback  = cpBoxEmphasisBack,
}

% Example
\NewTColorBox[auto counter,number within=section]{example}{!o}{%
  IfNoValueTF={#1}{}{label={#1}},
  colframe  = cpBoxExampleFrame,
  colback   = cpBoxExampleBack,
  coltitle  = cpBoxExampleTitle,
  colupper  = cpBoxExampleQuestion,
  fonttitle = \scshape,
  boxrule   = 1pt,
  arc       = 0.5mm,
  before upper={\textsc{Exemplo~{\thetcbcounter}}:~\ },
  lower separated       = false,
  underlay={%
    \begin{tcbclipinterior}
      \draw[help lines,
      step=3mm,
      cpBoxExampleLines,
      shift={(interior.north west)}]
      (interior.south west) grid (interior.north east);
    \end{tcbclipinterior}
  }
}

\newcommand*{\solution}{\tcblower}

% Tables
%------------------------------------------------------------------------------%

% Table environment options
\tcbset{tableBox/.style={
  center,
  breakable    = true,
  skin         = enhanced,
  colbacktitle = cpBoxTableTitleBack,
  coltitle     = cpBoxTableTitle,
  fonttitle    = \scshape,
  colframe     = cpBoxTableFrame,
  boxrule      = 0pt,
}}

% Tabular Box environment
% \begin{ntabular}[initial commands for tabular]{column definition}[width][internal margins at left and rigth]
\NewTColorBox{ntabular}{ O{} m O{1} O{5mm}}{
  tableBox,
  tabulars* = {\renewcommand{\arraystretch}{1.2}#1}%
              {@{\extracolsep{\fill}\hspace{#4}}#2@{\hspace{#4}}},
  width     = #3\linewidth,
}
% Floating Tabular Box environment
% \begin{ntable}[initial commands for tabular]{column definition}[width][internal margins at left and rigth]{Title}{label}
\NewTColorBox[auto counter,number within=chapter,list inside=lot]{ntable}{ O{} m O{1} O{5mm} m m }{
  tableBox,
  float          = htb,
  tabulars*      = {\renewcommand{\arraystretch}{1.2}#1}%
                   {@{\extracolsep{\fill}\hspace{#4}}#2@{\hspace{#4}}},
  width          = #3\linewidth,
  adjust text    = {\(\int\)},
  adjusted title = {Tabela~\thetcbcounter:~#5},
  label          = {#6},
}

\RequirePackage{longtable}

% Floating LongTable Box environment
% \begin{nlongtable}[initial commands for tabular]{column definition}{Title}{label}
\NewTColorBox[auto counter,number within=chapter,list inside=lot]{nlongtable}{ O{} m m m }{
  tableBox,
  float          = h,
  leftupper      = -3pt,
  rightupper     = 0pt,
  adjust text    = {\(\int\)},
  adjusted title = {Tabela~\thetcbcounter:~#3},
  label          = {#4},
  before upper   = {%
    \setlength{\LTpre}  {0pt}%
    \setlength{\LTleft} {0pt}%
    \setlength{\LTright}{0pt}%
    \arrayrulecolor{cpBoxTableFrame}%
    \renewcommand{\arraystretch}{1.2}%
    #1%
    \begin{longtable}{@{\hfill}#2@{\hfill}}
  },
  after upper = {\end{longtable}}
}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Online Box and QR codes
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage{qrcode}

\newcommand{\OnlineBox}[2]{{%
  \setlength{\parskip}{0pt}%
  \setlength{\abovedisplayskip}{0pt}%
  \begin{flushright}%
  \begin{minipage}[t]{0.76\linewidth}%
    \begin{tcolorbox}[
      breakable     = false,
      arc           = 1mm,
      toprule       = 1pt,
      rightrule     = 1pt,
      bottomrule    = 1pt,
      leftrule      = 1pt,
      colback       = cpBoxOnlineBack,
      colframe      = cpBoxOnlineBack] #2
  \end{tcolorbox}%
  \end{minipage}\hspace{-1.5mm}%
  \begin{minipage}[t]{0.2\linewidth}%
    \begin{tcolorbox}[
      breakable     = false,
      arc           = 1mm,
      left          = 1.2mm,
      right         = 1.2mm,
      top           = 1.2mm,
      bottom        = 1.2mm,
      colback       = cpBoxOnlineQRBack,
      colframe      = cpBoxOnlineFrame]
    \hypersetup{urlcolor=cpBoxOnlineQR}\qrcode[height=\linewidth]{#1}
  \end{tcolorbox}%
  \end{minipage}%
  \vspace{-\baselineskip}
  \end{flushright}
}}

\newcommand{\bookInfoLink}[1]{
  \begin{minipage}{25mm}
    \hypersetup{urlcolor=.}
    \qrcode[height=\linewidth]{#1}
  \end{minipage}
  \hspace{3mm}
  \begin{minipage}{81mm}
    \begin{hyphenrules}{nohyphenation}
      A versão mais recente desta apostila pode
      ser baixada clicando ou escaneando o código QR.
    \end{hyphenrules}
  \end{minipage}
}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Multicolumn formating
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage{multicol}
\setlength{\columnsep}{15pt}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Lists formating
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage{enumitem}

\setlist[description]{format=\normalfont\color{cpListItens}}
\setlist[enumerate]  {format=\normalfont\color{cpListItens}}
\setlist[itemize]    {format=\color{cpListItens}}

\setlist[description,1]{topsep=-0.4\baselineskip,itemsep=0pt}
\setlist[description,2]{topsep=0pt}

\setlist[enumerate,1]{topsep=-0.4\baselineskip,itemsep=0pt}
\setlist[enumerate,2]{topsep=0pt}

\setlist[itemize,1]{label={\large$\diamond$},topsep=-0.4\baselineskip,itemsep=0pt}
\setlist[itemize,2]{label={\large\textasteriskcentered},topsep=0pt}
\setlist[itemize,3]{label={\large\textopenbullet}}

\newlist{@lstAlphList}{enumerate}{1}
\newlist{@lstRomaList}{enumerate}{1}
\newlist{@lstMathList}{enumerate}{1}

\setlist[@lstAlphList,1]{label={\alph*)},  wide, labelwidth=0pt, labelindent=0pt}
\setlist[@lstRomaList,1]{label={\roman*)}, wide, labelwidth=0pt, labelindent=0pt}
\setlist[@lstMathList,1]{label={\alph*)},  wide, labelwidth=0pt, labelindent=0pt}

\AtBeginEnvironment{@lstMathList}{%
  \xpretocmd{\item}{\ifmmode\)\fi}{}{}
  \xapptocmd{\item}{\ifmmode\else\(\fi}{}{}
}

\AtEndEnvironment{@lstMathList}{\ifmmode\)\fi}

\NewDocumentEnvironment{@multicollist}{mmm}
{%
  \ifnum#2=1\relax\else%
    \begingroup%
    \setlength{\columnsep}{1pt}%
    \begin{multicols}{#2}%
    \raggedcolumns%
  \fi%
  \vspace{-\parsep}
  \begin{#1}[#3]%
}{%
  \end{#1}%
  \ifnum#2=1\relax\else%
    \end{multicols}%
    \endgroup%
  \fi%
}

\NewDocumentEnvironment{alphalist}{O{1} O{}}{\begin{@multicollist}{@lstAlphList}{#1}{#2}}{\end{@multicollist}}
\NewDocumentEnvironment{romanlist}{O{1} O{}}{\begin{@multicollist}{@lstRomaList}{#1}{#2}}{\end{@multicollist}}
\NewDocumentEnvironment{mathlist} {O{1} O{}}{\begin{@multicollist}{@lstMathList}{#1}{#2}}{\end{@multicollist}}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Exercicies and Answers
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\NewDocumentEnvironment{exercicesfmt}{o}
{%
\begin{small}%
  \begin{spacing}{1}%
    \begin{flushleft}%
      \IfNoValueTF{#1}%
      {\begin{multicols}{2}[~\vspace{-2\baselineskip}]}%
        {\begin{multicols}{2}[#1]}%
          \raggedcolumns%
          \setcounter{exercise}{0}%
          \setlength{\parskip}{1pt plus 1pt}%
          \setlength{\mathindent}{1em}%
        }{%
          \setlength{\mathindent}{1\defaultMathIndent}%
        \end{multicols}%
      \end{flushleft}%
    \end{spacing}%
  \end{small}%
}

\newcommand{\AnswersTitle}{Respostas}

\ifFastMode
%------------------------------------------------------------------------------%
% FastMode if true
% Do NOT move answers to document end
%------------------------------------------------------------------------------%

  \newcommand{\WriteAnswers}
  {%
    \chapter*{\AnswersTitle}%
    \addcontentsline{toc}{chapter}{\AnswersTitle}
  }

  \newcommand{\@AddChapterToAnswers}{}

  % Controling questons and answers sections
  %------------------------------------------------------------------------------%

  \newenvironment{exercises}
    {\begin{exercicesfmt}[\subsection*{Exercícios Seção \thesection}]}
    {\end{exercicesfmt}}

  \newenvironment{exercises*}
    {\begin{exercicesfmt}}
    {\end{exercicesfmt}}

  \newenvironment{answer}{\par\begingroup\color{blue}}{\endgroup}

%------------------------------------------------------------------------------%
\else

  \RequirePackage{answers}

  % Fix to a Writetofile bug
  \renewcommand{\Writetofile}[2]{%
    \@bsphack
    \Iffileundefined{#1}{}{%
      \Ifopen{#1}{%
        {%
          \begingroup
          %\let\protect\string %%% <----- removed
          \Ifanswerfiles{%
            \protected@iwrite{\@nameuse{#1@file}}{\afterassignment\let@protect@string}{#2}%
          }{}%
          \endgroup
        }%
      }{}%
    }%
    \@esphack
  }
  \def\let@protect@string{\let\protect\string}

  % File manipulation
  %------------------------------------------------------------------------------%

  \renewcommand{\solutionextension}{aux}

  \newcommand{\answerFile}{\jobname-answers}

  \Newassociation{answer}{Answer}{\answerFile}

  \newcommand{\WriteAnswers}{%
    \chapter*{\AnswersTitle}%
    \label{cap:respostas}%
    \addcontentsline{toc}{chapter}{\AnswersTitle}%
    \markboth{\AnswersTitle}{\AnswersTitle}%
    \setlength{\parskip}{1pt plus 1pt}%
    \setlength{\mathindent}{1em}%
    \begin{footnotesize}
    \begin{spacing}{1}
    \begin{flushleft}
    \begin{multicols}{2}
      \raggedcolumns
      \Readsolutionfile{\answerFile}
    \end{multicols}
    \end{flushleft}
    \end{spacing}
    \end{footnotesize}
    \setlength{\mathindent}{1\defaultMathIndent}%
  }

  \xapptocmd{\mainmatter}{\Opensolutionfile {\answerFile}}{}{}
  \xapptocmd{\backmatter}{\Closesolutionfile{\answerFile}}{}{}

  % Controling Chapter insertion on Answers
  %------------------------------------------------------------------------------%

  \newcommand{\AnswersChapterTitle}[2]{%
    \iftoggle{answers-chapter-#1}{
      \end{multicols}
      \vspace{2\baselineskip}
      {\color{cpTitleSection}
      \LARGE Capítulo #2
      \hspace{1em}{\hrulefill}}
      \par
      \vspace{2\baselineskip}
      \begin{multicols}{2}
      \raggedcolumns
    }{}
  }

  \newcommand{\@AddChapterToAnswers}{%
    \global\newtoggle{answers-chapter-\roman{chapterthis}}%
    \Writetofile{\answerFile}{\protect\AnswersChapterTitle{\roman{chapterthis}}{\thechapter}}%
  }

  \newcommand{\AnswersSectionTitle}[2]{%
%    \iftoggle{answers-section-#1}{
%      \par\vspace{2\baselineskip}
%      {\color{cpTitleSection}
%        \large Seção #2
%        \hspace{1em}{\hrulefill}}
%      \par\vspace{2\baselineskip}
%    }{}%
  }

  \BeforeBeginEnvironment{answer}{%
    \global\toggletrue{answers-chapter-\roman{chapterthis}}%
    \global\toggletrue{answers-section-\roman{chapterthis}-\roman{section}}%
  }

  % Controling questons and answers sections
  %------------------------------------------------------------------------------%

  \newenvironment{exercises}%
  {%
    \global\newtoggle{answers-section-\roman{chapterthis}-\roman{section}}%
    \Writetofile{\answerFile}{\protect\AnswersSectionTitle{\roman{chapterthis}-\roman{section}}{\thesection}}%
    \begin{exercicesfmt}[\subsection*{Exercícios Seção \thesection}]%
  }{%
    \end{exercicesfmt}%
  }

  \newenvironment{exercises*}%
  {%
    \global\newtoggle{answers-section-\roman{chapterthis}-\roman{section}}%
    \Writetofile{\answerFile}{\protect\AnswersSectionTitle{\roman{chapterthis}-\roman{section}}{\thesection}}%
    \begin{exercicesfmt}%
  }{%
    \end{exercicesfmt}%
  }

\fi % End of ifFastMode
%------------------------------------------------------------------------------%

% Formating and automatic referencing
%------------------------------------------------------------------------------%

\newcommand*{\answerRef}[1]{%
  \@ifundefined{r@answer:#1}%
    {}%
    {\hyperref[answer:#1]{[resp]}}%
}

\newtheoremstyle{exercises-sty}     % Style Name
                {0.5\baselineskip}  % Space above
                {0.3\baselineskip}  % Space below
                {}                  % Body font
                {0pt}               % Indent amount
                {}                  % Theorem head font
                {}                  % Punctuation after theorem head
                {1ex}               % Space after theorem head
{% Theorem head spec
  {{\color{cpEmph}\bfseries\arabic{exercise})}}
  \ifFastMode\else
    \label{exercise:\theexercise}%
    \answerRef{\theexercise}%
  \fi
}

\theoremstyle{exercises-sty}
\newtheorem{exercise}{}[section]

\ifFastMode\else
  \def\getthird#1.#2.#3\relax{{#3}}

  \renewcommand{\Answerlabel}[1]{%
    \label{answer:#1}%
    \hyperref[exercise:#1]{\getthird#1\relax)}
  }
\fi

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Page formating
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage[a4paper,margin=15mm,top=20mm,bottom=20mm]{geometry}

\pagecolor{cpPageBackground}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Make cover and information page
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage{wallpaper}

\newbool{hasCoverArt}    \boolfalse{hasCoverArt}
\newbool{hasCoverCredit} \boolfalse{hasCoverCredit}

\newcommand{\@coverArt}{}
\newcommand{\coverArt}[1]{
  \renewcommand{\@coverArt}{#1}
  \booltrue{hasCoverArt}
}

\newcommand{\@coverArtCredit}{}
\newcommand{\coverArtCredit}[1]{
  \renewcommand{\@coverArtCredit}{#1}
  \booltrue{hasCoverCredit}
}

%------------------------------------------------------------------------------%

% Author
\newcommand{\@authorText} {Nome do Autor}
\newcommand{\@authorCover}{Nome do Autor}

\renewcommand\@author[2][]%
{%
  \renewcommand{\@authorText} {#1}%
  \renewcommand{\@authorCover}{#2}%
}
\renewcommand\author{\@dblarg\@author}

% Title
\newcommand{\@titleText} {Título}
\newcommand{\@titleCover}{Título}

\renewcommand\@title[2][]%
{%
  \renewcommand{\@titleText} {#1}%
  \renewcommand{\@titleCover}{#2}%
}
\renewcommand\title{\@dblarg\@title}

% Subtitle
\newcommand{\@subtitleText} {}
\newcommand{\@subtitleCover}{}

\newcommand\@subtitle[2][]%
{%
  \renewcommand{\@subtitleText} {#1}%
  \renewcommand{\@subtitleCover}{#2}%
}
\newcommand\subtitle{\@dblarg\@subtitle}

%------------------------------------------------------------------------------%

\newcommand{\@institute}{}
\newcommand{\institute}[1]{\renewcommand{\@institute}{#1}}

\newcommand{\@bookInformation}{}
\newcommand{\bookInformation}[1]{\renewcommand{\@bookInformation}{#1}}

\newcommand{\makeBookCover}{%
  \newgeometry{margin=1mm}%
  \begingroup%
  ~\vfill%
  \setlength{\parskip}{1pt}%
  \setstretch{1}%
  \ifbool{hasCoverArt}%
         {\ThisCenterWallPaper{1}{\@coverArt}}%
         {\pagecolor{cpCoverDefaultBackgound}}%
  \begin{tcolorbox}[
      beforeafter skip balanced = 0pt,
      left skip        = 7mm,
      opacityback      = \BeltOpacity,
      sharp corners    = all,
      top              = 5mm,
      bottom           = 5mm,
      space            = 0.4,
      colback          = cpCoverBelt,
      enlarge right by = 11mm,
      width            = \linewidth+11mm,
      frame empty,
      % Upper (Title) format
      colupper     = cpCoverTitle,
      fontupper    = \Huge,
      halign upper = flush left,
      valign upper = center,
      leftupper    = 9mm,
      rightupper   = 30mm,
      % Lower (Author) format
      middle       = 3mm,
      collower     = cpCoverAuthor,
      fontlower    = \Large,
      halign lower = flush right,
      valign lower = center,
      leftlower    = 20mm,
      rightlower   = 29mm,
      % Separtion line
      lower separated = false,
    ]
    {\scshape\@titleCover}%
    \ifdefempty{\@subtitleCover}{}{ -- {\huge\@subtitleCover}}%
    \tcblower
    \@authorCover
  \end{tcolorbox}%
  \vspace*{\BeltPosition}%
  \endgroup%
  \restoregeometry%
  \clearpage%
  \pagecolor{cpPageBackground}%
}

\ifdefempty{\nicebooklet@cc}{%
  \newcommand{\makeLicense}{}
}{%
  \RequirePackage[type=CC,
                  modifier={\nicebooklet@cc},
                  imageposition=left,
                  version={4.0},
                  lang=brazilian]{doclicense}
  \newcommand{\makeLicense}{\doclicenseThis}
}

\newcommand{\makeTitleAuthor}{%
  {\Large \@titleText\ifdefempty{\@subtitleText}{}{ -- \@subtitleText}}\\[0.5\baselineskip]
   \@authorText\\[5mm]
   \ifdefempty{\@institute}{}{\@institute \newline}
   \@date
}

\newcommand{\makeInfomationPage}{%
  \clearpage
  \begingroup
    \setlength{\parskip}{7mm plus 3mm minus 2mm}
    \setlength{\parindent}{0pt}
    \thispagestyle{empty}
    \vspace*{0.3\textheight}
    \begin{small}
      \makeTitleAuthor
      \begin{spacing}{1}
        \vfill
        \ifdefempty{\@bookInformation}{}{\@bookInformation \par}
        \vfill
        \ifbool{hasCoverCredit}{Arte da capa: \@coverArtCredit ~\\[\baselineskip]}{}
        \makeLicense
      \end{spacing}
    \end{small}
  \endgroup
}

\newcommand{\makeBookBackCover}{\makeInfomationPage}

\AtBeginDocument{\makeBookCover\makeInfomationPage}
\AtEndDocument{\makeBookBackCover}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Page configuration
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

% Navegation buttons
%------------------------------------------------------------------------------%

\newcommand{\@linktoc} {$\;\equiv\;$}
\newcommand{\@linkprev}{$\;\blacktriangleleft\;$}
\newcommand{\@linkthis}{$\;\blacktriangle\;$}
\newcommand{\@linknext}{$\;\blacktriangleright\;$}

\newcounter{chapterprev}
\newcounter{chapterthis}
\newcounter{chapternext}

\setcounter{chapterprev}{-1}
\setcounter{chapterthis}{0}
\setcounter{chapternext}{1}

\newcommand{\@navigationlinks}{%
  \@ifundefined{r@cap:toc}%
               {{\color{cpPageHeader}\@linktoc}}%
               {\hyperref[cap:toc]{\@linktoc}}%
  \@ifundefined{r@ch:nav:\thechapterprev}%
               {{\color{cpPageHeader}\@linkprev}}%
               {\hyperref[ch:nav:\thechapterprev]{\@linkprev}}%
  \@ifundefined{r@ch:nav:\thechapterthis}%
               {{\color{cpPageHeader}\@linkthis}}%
               {\hyperref[ch:nav:\thechapterthis]{\@linkthis}}%
  \@ifundefined{r@ch:nav:\thechapternext}%
               {{\color{cpPageHeader}\@linknext}}%
               {\hyperref[ch:nav:\thechapternext]{\@linknext}}%
}

% Update navigation link and counters. This command is executed on each numbered chapter
\newcommand{\@setnavigation}{%
  \stepcounter{chapterprev}%
  \stepcounter{chapterthis}%
  \stepcounter{chapternext}%
  \label{ch:nav:\thechapterthis}%
}

% Page formating
%------------------------------------------------------------------------------%

\RequirePackage{fancyhdr}

\renewcommand*{\chaptermark}[1]{\markboth{#1}{#1}}
\renewcommand*{\sectionmark}[1]{}

\renewcommand{\headrulewidth}{0pt}
\setlength{\headheight}{17pt}

% Mainmather page formating
\fancypagestyle{fancymain}{%
  \fancyhf{}%
  \fancyhead[L]{\textcolor{cpPageHeader}{\nouppercase{\small\leftmark}}}%
  \fancyhead[R]{\textcolor{cpPageHeader}{\thepage}}%
  \fancyfoot[R]{\@navigationlinks}
}

% Backmather page formating
\fancypagestyle{fancyback}{%
  \fancyhf{}%
  \fancyhead[R]{\textcolor{cpPageHeader}{\thepage}}%
}

% Chapter page formating
\newcommand{\@chapterpagestylemain}{\fancypagestyle{plain}{\fancyhf{}\fancyfoot[R]{\@navigationlinks}}}
\newcommand{\@chapterpagestyleback}{\fancypagestyle{plain}{\fancyhf{}}}

\xapptocmd{\mainmatter}{\pagestyle{fancymain}\@chapterpagestylemain}{}{}
\xapptocmd{\backmatter}{\pagestyle{fancyback}\@chapterpagestyleback}{}{}

% Frontmatter page formating
\pagestyle{empty}
\fancyhf{}

% Frontmatter chapter page formating
\fancypagestyle{plain}{\fancyhf{}}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Titles configuration
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

\RequirePackage[explicit,nobottomtitles]{titlesec}

% \titleformat{command}[shape]{format}{label}{sep}{before}[after]
%
%   command - sectioning command to be redefined
%
%   shape   - paragraph shape
%             hang         - is the default value, with a hanging label.
%                            Like the standard section.
%             block        - typesets the whole title in a block (a paragraph)
%                            without additional formatting
%             display      - puts the label in a separate paragraph
%             leftmargin   - puts the title at the left margin. Titles at the
%                            very end of a page will be moved to the next one
%                            and will not stick out in the bottom margin, which
%                            means that large titles can lead to underfull pages.
%             rightmargin  - is like leftmargin but at the right margin.
%
%   format  - format to be applied to the whole title—label and text. This part
%             can contain vertical material which is typesseted just after the
%             space above the title.
%
%   label   - define the label. You may omit it if there is no section label
%             at that level, but note that by removing it the number is not
%             suppressed in the table of contents and running heads.
%
%   sep     - horizontal separation between label and title body and must be
%             a length. This space is vertical in display shape; in frame it
%             is the distance from text to frame. Both hlabeli and hsepi are
%             ignored in starred versions of sectioning commands. If you are
%             using picture and the like, set this parameter to 0 pt.
%
%   before  - code preceding the title body. The very last command can take
%             an argument, which is the title text.
%   after   - code following the title body. The typeset material is in vertical
%             mode with runin. Otherwise is ignored.

\titleformat{name=\part}[display]
  {\scshape\raggedright}
  {}{0pt}
  {
  \begin{center}
    \begin{tcolorbox}[
      sharp corners = all,
      halign        = flush left,
      top           = 20mm,
      bottom        = 20mm,
      left          = 7mm,
      height        = 20cm,
      width         = 0.9\linewidth,
      toprule       = 0pt,
      rightrule     = 0pt,
      bottomrule    = 0pt,
      leftrule      = 3mm,
      colback       = cpPageBackground,
      colupper      = cpTitlePart,
      colframe      = cpPartElements,
      fontupper     = \Huge,
      colbacktitle  = cpPageBackground,
      coltitle      = cpTitlePart,
      fonttitle     = \fontsize{80}{90}\selectfont,
      titlerule     = 0pt,
      toptitle      = 15mm,
      lefttitle     = 20mm,
      title         = \thepart] #1
    \end{tcolorbox}
  \end{center}
  }

\titleformat{name=\chapter}[display]
  {\color{cpTitleChapter}}
  {\rightline{\bfseries\fontsize{110}{120}\selectfont\thechapter\hspace*{0.5ex}}}
  {0pt}
  {\raggedright\setstretch{1.1}\Huge{#1}}
  [%
    \@setnavigation%
    \addtocontents{lof}{\protect\addvspace{-10\p@}}%
    \addtocontents{lot}{\protect\addvspace{-10\p@}}%
    \@AddChapterToAnswers%
  ]

\titleformat{name=\chapter,numberless}[display]
  {\color{cpTitleChapter}\raggedright}
  {}{0pt}
  {\raggedright\setstretch{1.1}\Huge{#1}}

\titleformat{name=\section}
  {\fontsize{24}{25}\selectfont\color{cpTitleSection}\raggedright}
  {\thesection}{1em}{#1}
  [\hrule{\hfill}]

\titleformat{name=\section,numberless}
  {\fontsize{24}{25}\selectfont\color{cpTitleSection}\raggedright}
  {}{0pt}{{#1}}
  [\hrule{\hfill}]

\titleformat{name=\subsection}
  {\fontsize{18}{19}\selectfont\color{cpTitleSection}\raggedright}
  {\thesubsection}{1em}{{#1}\hspace{1em}\hrulefill}

\titleformat{name=\subsection,numberless}
  {\fontsize{18}{18}\selectfont\color{cpTitleSection}\raggedright}
  {}{0pt}{{#1}\hspace{1em}\hrulefill}

\titleformat{name=\subsubsection,numberless}
  {\large\color{cpTitleSection}\raggedright}{}{0pt}{#1}

\titleformat{name=\paragraph}   [runin]{\color{cpTitleSection}}{}{0pt}{#1}
\titleformat{name=\subparagraph}[runin]{\itshape\color{cpTitleSection}}{}{0pt}{#1}

% {left}{before}{after}[right]
% Glue: 12pt plus 4pt minus 2pt
\titlespacing{\chapter}   {0mm}{0mm}{15mm}
\titlespacing{\section}   {0mm}{0mm plus 1mm minus 0mm}{-9mm plus 5mm minus 2mm}
\titlespacing{\subsection}{0mm}{0mm plus 1mm minus 0mm}{ 1mm plus 1mm minus 1mm}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
% Table of contents formating
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%

% Add bibliography to table of contents
\setcounter{tocdepth}{2}

\RequirePackage[nohints]{minitoc}

\setcounter{minitocdepth}{1}

\renewcommand{\mtcSfont}{\small\mdseries}

\xpretocmd{\tableofcontents}{%
  \dominitoc[n]%
  \begingroup%
  \setlength{\parskip}{3mm plus 1mm minus 1mm}%
  \addtocontents{toc}{\protect\label{cap:toc}}%
}{}{}

\xapptocmd{\tableofcontents}{%
  \endgroup%
  % \adjustmtc%
}{}{}

%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
\endinput
%------------------------------------------------------------------------------%
%------------------------------------------------------------------------------%
