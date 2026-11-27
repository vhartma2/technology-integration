local aliases = {
  ["adapt"] = "adaptation",
  ["disclosure"] = "ai disclosure",
  ["generative artificial intelligence (ai)"] = "generative ai",
}

local function escape(text)
  return (text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

function Pandoc(doc)
  local chapter = pandoc.path.filename(quarto.doc.input_file)
  if not chapter:match("^%d%d%-.+%.qmd$") then
    return doc
  end

  local glossary = assert(io.open(pandoc.path.join({quarto.project.directory, "glossary.qmd"})))
  local entries = {}
  for row in glossary:lines() do
    local term, definition, source = row:match("^| (.-) | (.-) | (.-) |$")
    if source and source:find("chapters/" .. chapter, 1, true) then
      local key = term:lower()
      local id = "definition-" .. key:gsub("[^%w]+", "-"):gsub("-$", "")
      entries[key] = {term = term, definition = definition, id = id}
    end
  end
  glossary:close()

  local used = {}
  local popovers = pandoc.List()
  doc = doc:walk({
    Strong = function(strong)
      local label = pandoc.utils.stringify(strong)
      local key = label:lower()
      key = aliases[key] or key
      local entry = entries[key]
      if not entry or used[key] then
        return nil
      end
      used[key] = true
      local id = entry.id
      popovers:insert(pandoc.RawBlock("html", string.format([[
<div class="glossary-popover" id="%s" popover role="dialog" aria-labelledby="%s-label">
  <p><strong id="%s-label">%s</strong></p>
  <p>%s</p>
  <button type="button" popovertarget="%s" popovertargetaction="hide" autofocus>Close</button>
</div>]], id, id, id, escape(entry.term), escape(entry.definition), id)))
      return pandoc.RawInline("html", string.format(
        '<button type="button" class="glossary-term" popovertarget="%s" aria-haspopup="dialog">%s</button>',
        id, escape(label)))
    end
  })
  doc.blocks:extend(popovers)
  return doc
end
