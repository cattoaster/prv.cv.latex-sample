\ProvidesClass{friggeri-cv}[2012/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}


%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\definecolor{custom.headercolor.1}{rgb}{0.4,0.64,0.78}
\definecolor{custom.cvtext.color.1}{HTML}{F1F3F4}

\ifdefined\@cv@print
\colorlet{green}{black}
\colorlet{orange}{black}
\colorlet{purple}{black}
\colorlet{red}{black}
\colorlet{blue}{black}
\colorlet{fillheader}{white}
\colorlet{header}{black}
\else
%\colorlet{fillheader}{gray}
%\colorlet{header}{white}
\colorlet{green}{gray}
\colorlet{orange}{gray}
\colorlet{purple}{gray}
\colorlet{red}{gray}
\colorlet{blue}{gray}
\colorlet{fillheader}{custom.headercolor.1}
\colorlet{header}{custom.cvtext.color.1}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}

\newfontfamily\bodyfont[]{Arial}
\newfontfamily\thinfont[]{Arial}
\newfontfamily\headingfont[]{Arial Bold}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor]{Arial}

\setmathfont{XITS Math}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\rolefont}{%
    \fontsize{14pt}{24pt}\selectfont%
    \thinfont%
    \color{white}%
}

\newcommand{\header}[3]{%
    \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=3cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
        \fontsize{40pt}{72pt}\color{header}%
        {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
        \fontsize{14pt}{24pt}\color{header}%
        \thinfont #3%
    };
    \end{tikzpicture}
    \vspace{0.5cm}
    \vspace{-6\parskip}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
    {%
        \color{%
            \ifcase\value{colorCounter}%
            blue\or%
            red\or%
            orange\or%
            green\or%
            purple\else%
            headercolor\fi%
        } #1#2#3%
    }%
    \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
    \par\vspace{\parskip}
    {%
        \LARGE\headingfont\color{headercolor}%
        \@sectioncolor #1%
    }
    \par\vspace{\parskip}
}

\renewcommand{\subsection}[2]{
    \par\vspace{.5\parskip}%
    \Large\headingfont\color{headercolor} #2%
    \par\vspace{.25\parskip}%
}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\RequirePackage{longtable}
\RequirePackage{tabu}

\setlength{\tabcolsep}{4pt}
\newenvironment{entrylist}{%
    \begin{longtabu} to \textwidth {@{\extracolsep{\fill}}ll}
    }{%
\end{longtabu}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
    #1&\parbox[t]{20cm}{%
        \textbf{#2}%
        \hfill%
        {\footnotesize\addfontfeature{Color=darkgray} #3}\\%
        #4\vspace{\parsep}%
    }\\}


%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
    \let\oldsection\section
    \renewcommand{\section}[1]{
        \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
    }
    \begin{textblock}{4.6}(0.5, 5.45)
        \begin{flushright}
            \obeycr
        }{%
        \restorecr
    \end{flushright}
\end{textblock}
\let\section\oldsection
}

%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[style=verbose, maxnames=99, sorting=ydnt]{biblatex}

\DeclareFieldFormat[article]{title}{#1\par}
\DeclareFieldFormat[inproceedings]{title}{#1\par}
\DeclareFieldFormat[misc]{title}{#1\par}
\DeclareFieldFormat[report]{title}{#1\par}

\DeclareBibliographyDriver{article}{%
    \printfield{title}%
    \newblock%
    \printnames{author}%
    \par%
    \newblock%
    {%
        \footnotesize\addfontfeature{Color=lightgray}\itshape%
        \usebibmacro{journal+issuetitle}%
        \setunit{\space}%
        \printfield{pages}%
        \newunit%
        \printlist{publisher}%
        \setunit*{\addcomma\space}%
        \printfield{year}%
        \newunit%
    }
    \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{inproceedings}{%
    \printfield{title}%
    \newblock%
    \printnames{author}%
    \par%
    \newblock%
    {%
        \footnotesize\addfontfeature{Color=lightgray}%
        \printfield{booktitle}%
        \setunit{\addcomma\space}%
        \printfield{year}%
        \setunit{\addcomma\space}%
        \printlist{location}%
        \newunit%
    }
    \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{misc}{%
    \printfield{title}%
    \newblock%
    \printnames{author}%
    \par%
    \newblock%
    {%
        \footnotesize\addfontfeature{Color=lightgray}\itshape%
        \printfield{booktitle}%
        \setunit*{\addcomma\space}%
        \printfield{note}%
        \setunit*{\addcomma\space}%
        \printfield{year}%
        \setunit{\addcomma\space}%
        \printlist{location}%
        \newunit%
    }
    \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{report}{%
    \printfield{title}%
    \newblock%
    \printnames{author}%
    \par%
    \newblock%
    {%
        \footnotesize\addfontfeature{Color=lightgray}\itshape%
        \printfield{type}%
        \setunit{\space}%
        \printfield{number}%
        \setunit{\addcomma\space}%
        \printfield{year}%
        \newunit%
    }
    \par\vspace{0.3\baselineskip}
}
%\DeclareNameFormat{newformat}{%
%	\usebibmacro{name:newformat}{\textbf{#1}}{\textbf{#3}}{#5}{#7}%
%	\usebibmacro{name:andothers}%
%}

%\DeclareNameFormat{newformat}{%
%\nameparts{#1}% split the name data, will not be necessary in future versions
%\usebibmacro{name:newformat}%
%\usebibmacro{name:andothers}%
%}

%\ifboolexpr{
%	test {\ifcsblank{namepartgiven}} and
%	test {\ifcsblank{namepartprefix}}
%}
%{}
%{\usebibmacro{name:revsdelim}}

% das alte mit Fehler
%\DeclareNameFormat{author}{%
%    \small\addfontfeature{Color=lightgray}%
%    \ifblank{#3}{}{#3\space}#1%
%    \ifthenelse{\value{listcount}<\value{liststop}}
%    {\addcomma\space}
%    {}%
%}

\DeclareNameFormat{author}{%
	\small\addfontfeature{Color=lightgray}%
	\ifboolexpr{
		test {\ifcsblank{namepartgiven}} and
		test {\ifcsblank{namepartprefix}}
	}
	{}
	{\usebibmacro{name:revsdelim}}
	\ifthenelse{\value{listcount}<\value{liststop}}
	{\addcomma\space}
	{}%
}

\newcommand{\printbibsection}[2]{
    \begin{refsection}
        \nocite{*}
        \printbibliography[sorting=chronological, type={#1}, title={#2}, heading=subbibliography]
    \end{refsection}
}

\DeclareSortingScheme{chronological}{
    \sort[direction=descending]{\field{year}}
    \sort[direction=descending]{\field{month}}
}



%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=2cm,right=1.5cm,bottom=2.5cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}

% classical \today definition
\def\today{\number\day\,.\space
    \ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
     \space\number\year}