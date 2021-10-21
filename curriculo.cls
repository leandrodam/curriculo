\ProvidesClass{curriculo}
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

\usepackage[brazilian]{babel}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{fontawesome}
\usepackage{graphicx}
\usepackage{ragged2e}
\usepackage{booktabs}
\usepackage{tikz}
\usepackage[sfdefault]{ClearSans}
\usepackage[T1]{fontenc}
\usepackage{xcolor}
\usepackage[absolute,overlay]{textpos}
\usepackage{etoolbox}
\usepackage{ifmtarg}
\usepackage{ifthen}
\usepackage{pgffor}
\usepackage{marvosym}
\usepackage{parskip}
\usepackage{enumitem}
\usepackage{longtable} % Required for tables that span multiple pages

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------

\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{lightgray}{HTML}{B9B9B9}
\definecolor{gray}{HTML}{888888}
\definecolor{darkgray}{HTML}{4D4D4D}
\definecolor{indigo}{HTML}{4A4FB1}

%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

% \renewcommand{\bfseries}{\color{darkgray}} % Make \textbf produce coloured text instead

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

\usetikzlibrary{shapes, backgrounds}
\tikzset{x=1cm, y=1cm} % Default tikz units

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\settowidth{\SectionTitleLength}{\huge #1 }% Calculate the width of the section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

% Define custom commands for CV info
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}

\newcommand{\sobre}[1]{\renewcommand{\sobre}{#1}}
\newcommand{\formacao}[1]{\renewcommand{\formacao}{#1}}
\newcommand{\idiomas}[1]{\renewcommand{\idiomas}{#1}}
\newcommand{\cursos}[1]{\renewcommand{\cursos}{#1}}

\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\usepackage[left=6.5cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}

\usepackage{hyperref}

%----------------------------------------------------------------------------------------
%	 CV TITLE
%----------------------------------------------------------------------------------------

\newcommand{\cvtitle}{
    \begin{flushleft}
        \vspace{1.5em}
        {\Huge\color{indigo}\cvname} \\[0.5em]
        {\Large\color{gray}\cvjobtitle} \\[0.5em]
        \textcolor{indigo}{\rule{\textwidth}{2pt}}
    \end{flushleft}
    \vspace{0.5em}
}

%----------------------------------------------------------------------------------------
%	 SECTION
%----------------------------------------------------------------------------------------

\renewcommand{\section}[1]{
    {
        \colorbox{black}{\bfseries\color{white}\MakeUppercase{#1}} \\[0.3em]
	}
}

%----------------------------------------------------------------------------------------
%	 RATING DOTS
%----------------------------------------------------------------------------------------

\newcommand{\icon}[3]{\phantom{x}{#3\color{#2}#1}\phantom{x}}

\newcommand{\pictofraction}[6]{
    \pgfmathparse{#3 - 1}\foreach \n in {0,...,\pgfmathresult}{\icon{#1}{#2}{#6}}
    \pgfmathparse{#5 - 1}\foreach \n in {0,...,\pgfmathresult}{\icon{#1}{#4}{#6}}
}

%----------------------------------------------------------------------------------------
%	CHARTS
%---------------------------------------------------------------------------------------- 

\newcounter{barcount}

% Environment to hold a new bar chart
\newenvironment{barchart}[1]{ % The only parameter is the maximum bar width, in cm
	\newcommand{\barwidth}{0.2}
	\newcommand{\barsep}{0.2}
	
	% Command to add a bar to the bar chart
	\newcommand{\baritem}[2]{ % The first argument is the bar label and the second is the percentage the current bar should take up of the total width
		\pgfmathparse{##2}
		\let\perc\pgfmathresult
		
		\pgfmathparse{#1}
		\let\barsize\pgfmathresult
		
		\pgfmathparse{\barsize*##2/100}
		\let\barone\pgfmathresult
		
		\pgfmathparse{(\barwidth*\thebarcount)+(\barsep*\thebarcount)}
		\let\barx\pgfmathresult
		
		\pgfmathparse{(\barwidth/2)}
		\let\halfbarwidth\pgfmathresult
		
		\filldraw[fill=indigo, draw=none] (0,-\barx) rectangle (\barone,-\barx-\barwidth);
		
		\node [label=180:\colorbox{white}{\textcolor{black}{##1}}] at (0,-\barx-\halfbarwidth) {};
		\addtocounter{barcount}{1}
	}
	\begin{tikzpicture}
		\setcounter{barcount}{0}
}{
	\end{tikzpicture}
}

%----------------------------------------------------------------------------------------
%	 TABULAR EVENTS
%----------------------------------------------------------------------------------------

\newcommand{\cvformacao}[4]{
    {\small\textbf{#1}} \newline {\footnotesize #2}
    & {\small\textbf{#3}} \newline {\footnotesize #4}
    \vspace{0.5em}
}

\newcommand{\cvcurso}[3]{
    {\small\textbf{#1}\hfill\footnotesize{#2}\newline\textit{#3}\hfill}
    \vspace{0.4em}
}

\newcommand{\cvevent}[4]{
    {\small #1} & {\small\textbf{#2}\hfill\textit{#3}\newline{\color{black!70}#4}}
    \vspace{0.5em}
}

%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\sidebarsection}[3]{
    \colorbox{#1}{\color{#2}\MakeUppercase{#3}} \\[0.5em]
}

\newcommand{\sideblock}[2]{
    \begin{flushright}
        {\footnotesize\sidebarsection{black}{white}{#1}}
        {\small\color{white}#2}
    \end{flushright}
    \vspace{1.5em}
}

\newcommand{\makeprofile}{
	\begin{tikzpicture}[remember picture,overlay]
   		\node[rectangle, fill=indigo, anchor=south, minimum width=9cm, minimum height=\paperheight-2.5cm] (box) at (-5cm,-\paperheight){};
	\end{tikzpicture}
	
	\begin{textblock}{5}(0.5,0.2)
		
		\ifthenelse{\equal{\profilepic}{}}{}{
			\begin{center}
				\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
					\clip (600/2, 567/2) circle (567/2);
					\node[anchor=north west,inner sep=0pt,outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
				\end{tikzpicture}
			\end{center}
		}
		
        % QUEM SOU EU
        \sideblock{Quem sou eu}{\sobre}
        
		% CONTATO
        \sideblock{Contato}{
            \cvaddress \parbox[t][1em][t]{1.75em}{\centering\faMapMarker} \\
            \cvmail \parbox[t][1em][t]{1.75em}{\centering\faEnvelope} \\
            \cvnumberphone \parbox[t][1em][t]{1.75em}{\centering\faWhatsapp} \\
            \cvlinkedin \parbox[t][1em][t]{1.75em}{\centering\faLinkedinSquare} \\
            \cvgithub \parbox[t][1em][t]{1.75em}{\centering\faGithubAlt} \\
            \bigskip
        }
        
        % FORMAÇÃO
        \sideblock{Formação}{\formacao}
        
        % IDIOMAS
        \sideblock{Idiomas}{\idiomas}
        
        % CURSOS COMPLEMENTARES
        \sideblock{Cursos Complementares}{\cursos}
		
	\end{textblock}
}
