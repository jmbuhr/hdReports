#' Initialize protein structure display
#'
#' Put this at the top of your Rmarkdown document.
#'
#' @return Code that is inserted into the output document
#' @export
init_molstar <- function() {
  knitr::asis_output(
    '
<link rel="stylesheet" type="text/css" href="https://molstar.org/viewer/molstar.css" data-external="1"/>
<script type="text/javascript" src="https://molstar.org/viewer/molstar.js" data-external="1"></script>
'
  )
}

#' Include a protein structure
#'
#' Use this function to embed a protein structure into your html output document.
#'
#' @param pdb_id Protein Database ID of the protein structure to embed
#'
#' @return Code that is inserted into the output document
#' @export
include_structure <- function(pdb_id) {
  label <- knitr::opts_current$get("label")
  label <- stringr::str_remove_all(label, "\\W")
  knitr::asis_output(
    glue::glue(
      '
<div id="app{label}" class="app"></div>

<script type="text/javascript">
var viewer{label} = new molstar.Viewer("app{label}", {{
layoutIsExpanded: false,
layoutShowControls: false,
layoutShowRemoteState: false,
layoutShowSequence: true,
layoutShowLog: false,
layoutShowLeftPanel: true,
viewportShowExpand: true,
viewportShowSelectionMode: false,
viewportShowAnimation: false,
pdbProvider: "rcsb",
emdbProvider: "rcsb",
}});
viewer{label}.loadPdb("{pdb_id}");
</script>
'
    )
  )
}
