-- OpenerTrainer: impara le opener di rotation.
-- Lista di step per spec, verde al cast riuscito, delta temporale tra un cast e l'altro.
-- Retail Midnight 12.1+. Solo lettura: nessun secure template, nessun combat lockdown.

local ADDON_NAME = ...

local VERSION = "1.2.1"
local ICON_PATH = "Interface\\AddOns\\OpenerTrainer\\Media\\icon"
local ICON_FALLBACK = "Interface\\Icons\\INV_Misc_QuestionMark"
local ICON_INFO = "Interface\\Icons\\INV_Misc_Note_01"

-- ---------------------------------------------------------------------------
-- Localizzazione: default enUS, override in base al locale del client
-- ---------------------------------------------------------------------------

local L = {
    LOADED = "v%s loaded — /opener",
    NOT_READY = "Not initialized yet.",
    RUN_RESET = "Run reset.",
    NO_OPENER_HINT = "No opener: open the Editor",
    RESET = "Reset",
    EDITOR = "Editor",
    EDITOR_TITLE = "OpenerTrainer — Editor",
    NO_OPENER_SELECT = "— no opener —",
    NEW = "New",
    DELETE = "Delete",
    RENAME = "Rename",
    ADD_INFO = "+ Info step",
    SPELLS_LABEL = "Character spells (click = add)",
    STEPS_LABEL = "Opener steps (click row = x1/x2/x3)",
    ADD_BY_ID = "Add by ID %s:",
    CLICK_CYCLE = "Click: cycle x1/x2/x3",
    INFO_STEP_TT = "Info step (always green)",
    CREATE_FIRST = "Create an opener first (New button).",
    NO_OPENERS_SPEC = "No openers for this spec: create one with New.",
    CHANGED_ABORT_DELETE = "Active opener changed meanwhile: deletion cancelled.",
    CHANGED_ABORT_STEP = "Active opener changed meanwhile: step not added.",
    CHANGED_ABORT_RENAME = "Active opener changed meanwhile: not renamed.",
    POPUP_NEW = "Name of the new opener:",
    POPUP_DELETE = "Delete opener \"%s\"?",
    POPUP_INFO = "Info step text (always green):",
    POPUP_RENAME = "New name for \"%s\":",
    MM_LEFT = "Left click: show/hide tracker + icon bar",
    MM_SHIFT = "Shift+click: show/hide icon bar",
    MM_RIGHT = "Right click: opener editor",
    MM_DRAG = "Drag: move this button",
    AUTORESET_ON = "Auto-reset on leaving combat: ON",
    AUTORESET_OFF = "Auto-reset on leaving combat: OFF",
    AUTORESET_LABEL = "Auto-reset when leaving combat",
    STATUS = "v%s — spec %s, opener %s (%d of %d), expected step %d",
    STATUS_NONE = "none",
    EXPORT = "Export",
    IMPORT = "Import",
    POPUP_EXPORT = "Export string for \"%s\" (CTRL+C):",
    POPUP_IMPORT = "Paste the opener string:",
    IMPORT_OK = "Opener \"%s\" imported: %d steps (%d skipped).",
    IMPORT_TALENTS_NOTE = "Talent string included — open Talents > Activate to apply it.",
    IMPORT_BAD = "Invalid import string.",
    NOT_TALENTED = "Not talented / unknown on this character",
    TALENTS = "Talents",
    POPUP_TALENTS = "Talent string for \"%s\" — optional (CTRL+C to copy, paste to save):",
    TALENTS_SAVED = "Talent string saved.",
    TALENTS_REMOVED = "Talent string removed.",
    TALENTS_INVALID = "Invalid talent string.",
    APPLY = "Activate",
    SIDEBAR_OPENERS = "OPENERS",
    PRESETS = "Presets",
    NO_PRESETS = "No presets for this spec.",
    SPELLS_COL = "CHARACTER SPELLS",
    STEPS_COL = "SEQUENCE (drag to reorder)",
    SEARCH_PH = "Search or spell ID...",
    TALENTS_EMPTY = "No talent string.",
    TALENTS_COMBAT = "Cannot change talents in combat.",
    TALENTS_UNSUPPORTED = "Talent import is not supported by this client.",
    TALENTS_IMPORTED = "Loadout \"%s\" saved to your talent loadouts.",
    TALENTS_APPLIED = "Loadout \"%s\" activated.",
    TALENTS_APPLY_FAIL = "Could not import/activate the loadout (%s).",
    SEEDED = "Havoc openers preloaded: Aldrachi Raid and Fel-Scarred M+ (edit them in the Editor).",
}

if GetLocale() == "itIT" then
    L.LOADED = "v%s caricato — /opener"
    L.NOT_READY = "Non ancora inizializzato."
    L.RUN_RESET = "Run azzerata."
    L.NO_OPENER_HINT = "Nessuna opener: apri l'Editor"
    L.NO_OPENER_SELECT = "— nessuna opener —"
    L.NEW = "Nuova"
    L.DELETE = "Elimina"
    L.RENAME = "Rinomina"
    L.ADD_INFO = "+ Step info"
    L.SPELLS_LABEL = "Spell del personaggio (click = aggiungi)"
    L.STEPS_LABEL = "Step opener (click riga = x1/x2/x3)"
    L.ADD_BY_ID = "Aggiungi per ID %s:"
    L.CLICK_CYCLE = "Click: cicla x1/x2/x3"
    L.INFO_STEP_TT = "Step informativo (sempre verde)"
    L.CREATE_FIRST = "Crea prima una opener (pulsante Nuova)."
    L.NO_OPENERS_SPEC = "Nessuna opener per questa spec: creane una con Nuova."
    L.CHANGED_ABORT_DELETE = "Opener cambiata nel frattempo: eliminazione annullata."
    L.CHANGED_ABORT_STEP = "Opener cambiata nel frattempo: step non aggiunto."
    L.CHANGED_ABORT_RENAME = "Opener cambiata nel frattempo: nome non modificato."
    L.POPUP_NEW = "Nome della nuova opener:"
    L.POPUP_DELETE = "Eliminare la opener \"%s\"?"
    L.POPUP_INFO = "Testo dello step informativo (sempre verde):"
    L.POPUP_RENAME = "Nuovo nome per \"%s\":"
    L.MM_LEFT = "Click sinistro: mostra/nascondi tracker + barra icone"
    L.MM_SHIFT = "Shift+click: mostra/nascondi barra icone"
    L.MM_RIGHT = "Click destro: editor opener"
    L.MM_DRAG = "Trascina: sposta il pulsante"
    L.AUTORESET_ON = "Auto-reset a fine combat: ATTIVO"
    L.AUTORESET_OFF = "Auto-reset a fine combat: DISATTIVO"
    L.AUTORESET_LABEL = "Auto-reset all'uscita dal combat"
    L.STATUS = "v%s — spec %s, opener %s (%d di %d), step atteso %d"
    L.STATUS_NONE = "nessuna"
    L.EXPORT = "Esporta"
    L.IMPORT = "Importa"
    L.POPUP_EXPORT = "Stringa di export per \"%s\" (CTRL+C):"
    L.POPUP_IMPORT = "Incolla la stringa della opener:"
    L.IMPORT_OK = "Opener \"%s\" importata: %d step (%d saltati)."
    L.IMPORT_TALENTS_NOTE = "Stringa talenti inclusa — aprila da Talenti > Attiva per applicarla."
    L.IMPORT_BAD = "Stringa di import non valida."
    L.NOT_TALENTED = "Non talentata / sconosciuta su questo personaggio"
    L.TALENTS = "Talenti"
    L.POPUP_TALENTS = "Stringa talenti per \"%s\" — opzionale (CTRL+C per copiare, incolla per salvare):"
    L.TALENTS_SAVED = "Stringa talenti salvata."
    L.TALENTS_REMOVED = "Stringa talenti rimossa."
    L.TALENTS_INVALID = "Stringa talenti non valida."
    L.APPLY = "Attiva"
    L.SIDEBAR_OPENERS = "OPENER"
    L.PRESETS = "Preset"
    L.NO_PRESETS = "Nessun preset per questa spec."
    L.SPELLS_COL = "SPELL DEL PERSONAGGIO"
    L.STEPS_COL = "SEQUENZA (trascina per riordinare)"
    L.SEARCH_PH = "Cerca o ID spell..."
    L.TALENTS_EMPTY = "Nessuna stringa talenti."
    L.TALENTS_COMBAT = "Impossibile cambiare talenti in combat."
    L.TALENTS_UNSUPPORTED = "Import talenti non supportato da questo client."
    L.TALENTS_IMPORTED = "Loadout \"%s\" salvato tra i tuoi loadout talenti."
    L.TALENTS_APPLIED = "Loadout \"%s\" attivato."
    L.TALENTS_APPLY_FAIL = "Impossibile importare/attivare il loadout (%s)."
    L.SEEDED = "Opener Havoc precaricate: Aldrachi Raid e Fel-Scarred M+ (modificabili dall'Editor)."
end

local COLOR_DONE = { 0.25, 1.00, 0.35 }
local COLOR_CURRENT = { 1.00, 0.90, 0.25 }
local COLOR_PENDING = { 0.85, 0.85, 0.85 }
local COLOR_MISSING = { 1.00, 0.30, 0.30 }

local db -- OpenerTrainerDB, valorizzato in ADDON_LOADED

-- ---------------------------------------------------------------------------
-- Utilità
-- ---------------------------------------------------------------------------

local function Print(msg)
    print("|cff40ff80OpenerTrainer|r " .. tostring(msg))
end

-- Scrub anti-Secret-Value (midnight 12.0): confrontare un secret number con ==
-- lancia errore e tainta l'addon per la sessione. tonumber() è lo scrub canonico.
local function ScrubID(id)
    return tonumber(id)
end

-- true se il valore è un Secret Value 12.0 (confrontarlo direttamente = errore + taint)
local function IsSecret(v)
    return type(issecretvalue) == "function" and issecretvalue(v)
end

local function GetCurrentSpecID()
    local idx
    if type(GetSpecialization) == "function" then
        idx = GetSpecialization()
    elseif C_SpecializationInfo and C_SpecializationInfo.GetSpecialization then
        idx = C_SpecializationInfo.GetSpecialization()
    end
    if not idx then return 0 end
    local getInfo = GetSpecializationInfo
        or (C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo)
    if not getInfo then return 0 end
    local ok, specID = pcall(getInfo, idx)
    if ok and type(specID) == "number" then return specID end
    return 0
end

local function GetSpellIcon(spellID)
    if C_Spell and C_Spell.GetSpellTexture then
        local ok, tex = pcall(C_Spell.GetSpellTexture, spellID)
        if ok and tex then return tex end
    end
    return ICON_FALLBACK
end

local function GetSpellName(spellID)
    if C_Spell and C_Spell.GetSpellInfo then
        local ok, info = pcall(C_Spell.GetSpellInfo, spellID)
        if ok and type(info) == "table" and info.name then return info.name end
    end
    return "Spell " .. tostring(spellID)
end

-- ---------------------------------------------------------------------------
-- DB
-- ---------------------------------------------------------------------------

local function InitDB()
    OpenerTrainerDB = OpenerTrainerDB or {}
    db = OpenerTrainerDB
    if db.schema == nil then db.schema = 1 end
    if db.openers == nil then db.openers = {} end
    if db.active == nil then db.active = {} end
    if db.minimap == nil then db.minimap = { angle = 215 } end
    if db.minimap.angle == nil then db.minimap.angle = 215 end
    -- Default: finestre CHIUSE su un personaggio nuovo; si aprono da icona/comando
    if db.hidden == nil then db.hidden = true end
    if db.barHidden == nil then db.barHidden = true end
    if db.autoReset == nil then db.autoReset = true end
    if db.spellPool == nil then db.spellPool = {} end
end

local function GetOpeners()
    local spec = GetCurrentSpecID()
    db.openers[spec] = db.openers[spec] or {}
    return db.openers[spec], spec
end

local function GetActiveOpener()
    local list, spec = GetOpeners()
    local idx = db.active[spec]
    if not idx or not list[idx] then
        idx = list[1] and 1 or nil
        db.active[spec] = idx
    end
    return idx and list[idx] or nil, idx, list, spec
end

-- ---------------------------------------------------------------------------
-- Spellbook: enumerazione spell note (tutte le classi)
-- ---------------------------------------------------------------------------

-- Spell di utilità che non c'entrano con le rotation: escluse dal picker.
-- Auto Attack via ID/API (indipendente dalla lingua), il resto per nome.
local PICKER_BLACKLIST_IDS = {
    [6603] = true,   -- Auto Attack
    [83958] = true,  -- Mobile Banking
    [125439] = true, -- Revive Battle Pets
    [131347] = true, -- Glide (DH)
}
local PICKER_BLACKLIST_NAMES = {
    ["auto attack"] = true,
    ["attacco automatico"] = true,
    ["mobile banking"] = true,
    ["anomaly detection mark i"] = true,
    ["mechanism bypass"] = true,
    ["path of unyielding blight"] = true,
    ["revive battle pets"] = true,
    ["recuperate"] = true,
    ["glide"] = true,
    ["activating specialization"] = true,
}

local function PickerBlacklisted(sid, name)
    if sid and PICKER_BLACKLIST_IDS[sid] then return true end
    if name and PICKER_BLACKLIST_NAMES[name:lower()] then return true end
    return false
end

local function EnumerateKnownSpells()
    local out, seen, seenNames = {}, {}, {}
    if not (C_SpellBook and C_SpellBook.GetNumSpellBookSkillLines
        and C_SpellBook.GetSpellBookSkillLineInfo and C_SpellBook.GetSpellBookItemInfo) then
        return out
    end
    local bank = (Enum and Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Player) or 0
    local spellType = Enum and Enum.SpellBookItemType and Enum.SpellBookItemType.Spell
    local okLines, numLines = pcall(C_SpellBook.GetNumSpellBookSkillLines)
    if not okLines or type(numLines) ~= "number" then return out end
    for line = 1, numLines do
        local okLine, li = pcall(C_SpellBook.GetSpellBookSkillLineInfo, line)
        if okLine and type(li) == "table" and not li.offSpecID then
            local offset = tonumber(li.itemIndexOffset) or 0
            local count = tonumber(li.numSpellBookItems) or 0
            for j = 1, count do
                local okItem, info = pcall(C_SpellBook.GetSpellBookItemInfo, offset + j, bank)
                if okItem and type(info) == "table" then
                    local sid = ScrubID(info.spellID)
                    local isSpell = (spellType == nil) or (tonumber(info.itemType) == spellType)
                    if sid and C_SpellBook.IsAutoAttackSpellBookItem then
                        local okA, isAuto = pcall(C_SpellBook.IsAutoAttackSpellBookItem, offset + j, bank)
                        if okA and isAuto then sid = nil end
                    end
                    if sid and PickerBlacklisted(sid, info.name) then sid = nil end
                    if sid and isSpell and not info.isPassive and not seen[sid] then
                        local nm = info.name or GetSpellName(sid)
                        local lname = nm:lower()
                        -- Dedup anche per NOME: il gioco tiene ID interni
                        -- diversi per la stessa spell mostrata (rank/varianti)
                        if not seenNames[lname] then
                            seen[sid] = true
                            seenNames[lname] = true
                            out[#out + 1] = {
                                spellID = sid,
                                name = nm,
                                icon = info.iconID or GetSpellIcon(sid),
                            }
                        end
                    end
                end
            end
        end
    end
    -- Fallback: se lo spellbook non ha reso nulla, scansione action bar
    -- (gestisce sia il ritorno a tabella sia quello a tupla actionType, id)
    if #out == 0 and C_ActionBar and C_ActionBar.GetActionInfo then
        for slot = 1, 180 do
            local okA, a, b = pcall(C_ActionBar.GetActionInfo, slot)
            if okA and a then -- truthiness, non ~= nil: un Secret non va mai confrontato
                local atype, aid
                if type(a) == "table" then atype, aid = a.actionType, a.id else atype, aid = a, b end
                if not IsSecret(atype) and atype == "spell" then
                    local sid = ScrubID(aid)
                    if sid and not seen[sid] then
                        seen[sid] = true
                        out[#out + 1] = { spellID = sid, name = GetSpellName(sid), icon = GetSpellIcon(sid) }
                    end
                end
            end
        end
    end
    -- Accumula nel pool persistente: cattura anche le forme visibili solo
    -- temporaneamente (es. lo spellbook durante Metamorphosis mostra le
    -- versioni trasformate), che così restano cercabili per sempre
    if db and db.spellPool then
        for _, s in ipairs(out) do db.spellPool[s.spellID] = true end
    end
    table.sort(out, function(a, b) return (a.name or "") < (b.name or "") end)
    return out
end

-- ---------------------------------------------------------------------------
-- Mappa dei talenti: spellID -> selezionato (true/false).
-- Rosso SOLO per nodi del talent tree non selezionati: le forme override
-- (Death Sweep del DH, le forme del prete Shadow, ecc.) non stanno
-- nell'albero e non vengono mai giudicate — su tutte le classi, senza
-- apprendimento. Se la scansione fallisce: mappa nil = nessun rosso.
-- ---------------------------------------------------------------------------

local talentSelected -- nil = mappa non disponibile (fail-open)

local function BuildTalentMap()
    local map = {}
    local ok = pcall(function()
        local configID = C_ClassTalents and C_ClassTalents.GetActiveConfigID
            and C_ClassTalents.GetActiveConfigID()
        assert(configID, "no talent config")
        local cfg = C_Traits.GetConfigInfo(configID)
        for _, treeID in ipairs(cfg.treeIDs) do
            for _, nodeID in ipairs(C_Traits.GetTreeNodes(treeID)) do
                local node = C_Traits.GetNodeInfo(configID, nodeID)
                if node and node.entryIDs then
                    local activeEntry = node.activeEntry and node.activeEntry.entryID
                    local picked = (tonumber(node.activeRank) or 0) > 0
                        or (tonumber(node.ranksPurchased) or 0) > 0
                    for _, entryID in ipairs(node.entryIDs) do
                        local entry = C_Traits.GetEntryInfo(configID, entryID)
                        local def = entry and entry.definitionID
                            and C_Traits.GetDefinitionInfo(entry.definitionID)
                        local sid = def and tonumber(def.spellID)
                        if sid then
                            -- nei choice node conta solo l'entry attiva
                            local isSel = picked and (activeEntry == nil or activeEntry == entryID)
                            if isSel then
                                map[sid] = true
                            elseif map[sid] == nil then
                                map[sid] = false
                            end
                        end
                    end
                end
            end
        end
    end)
    talentSelected = ok and map or nil
end

-- ---------------------------------------------------------------------------
-- Tracker: stato della run
-- ---------------------------------------------------------------------------

local run = { pointer = 1, castsInStep = 0, lastCastTime = nil, deltas = {}, intra = {}, done = {} }

local Tracker_Refresh, Editor_RefreshSteps, Editor_RefreshSpells, Editor_RefreshHeader, Editor_RefreshAll, Bar_Refresh -- fwd
local ExportOpener, ImportOpener, ApplyTalentString -- fwd (definiti dopo l'editor, usati dai suoi pulsanti)

local function AdvancePastInfo(steps)
    while run.pointer <= #steps and steps[run.pointer].kind == "info" do
        run.pointer = run.pointer + 1
    end
end

local function ResetRun()
    run = { pointer = 1, castsInStep = 0, lastCastTime = nil, deltas = {}, intra = {}, done = {} }
    local opener = GetActiveOpener()
    if opener then AdvancePastInfo(opener.steps) end
end

-- ---------------------------------------------------------------------------
-- Kit grafico flat (stile EllesmereUI) condiviso da tutte le finestre
-- ---------------------------------------------------------------------------

-- Palette (valori esatti dal sorgente EllesmereUI)
local ACCENT = { r = 12 / 255, g = 210 / 255, b = 157 / 255 } -- #0CD29D
local PANEL_BG = { 0.05, 0.07, 0.09 }
local BTN_BG = { 0.061, 0.095, 0.120 }
local DD_BG = { 0.075, 0.113, 0.141 }

-- Font di gioco condensed (sempre presente, look pulito): niente dipendenze
-- da altri addon.
local EDITOR_FONT = "Fonts\\ARIALN.TTF"

local function EFont(parent, size, alpha)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont(EDITOR_FONT, size, "")
    fs:SetTextColor(1, 1, 1, alpha or 1)
    return fs
end

local function ETex(parent, layer, r, g, b, a)
    local t = parent:CreateTexture(nil, layer or "BACKGROUND")
    t:SetColorTexture(r, g, b, a or 1)
    t:SetSnapToPixelGrid(false)
    t:SetTexelSnappingBias(0)
    return t
end

-- Bordo 1px: 4 strisce piatte (pattern EllesmereUI, niente BackdropTemplate)
local function EBorder(frame, r, g, b, a)
    local edges = {}
    local function strip()
        local t = ETex(frame, "OVERLAY", r, g, b, a)
        edges[#edges + 1] = t
        return t
    end
    local top = strip(); top:SetPoint("TOPLEFT"); top:SetPoint("TOPRIGHT"); top:SetHeight(1)
    local bot = strip(); bot:SetPoint("BOTTOMLEFT"); bot:SetPoint("BOTTOMRIGHT"); bot:SetHeight(1)
    local lf = strip(); lf:SetPoint("TOPLEFT"); lf:SetPoint("BOTTOMLEFT"); lf:SetWidth(1)
    local rt = strip(); rt:SetPoint("TOPRIGHT"); rt:SetPoint("BOTTOMRIGHT"); rt:SetWidth(1)
    return {
        SetColor = function(_, cr, cg, cb, ca)
            for _, t in ipairs(edges) do t:SetColorTexture(cr, cg, cb, ca or 1) end
        end,
    }
end

-- Pulsante flat a due stati (normal/hover), come MakeStyledButton di Ellesmere
local function EButton(parent, w, h, text, size, onClick)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(w, h)
    b.bg = ETex(b, "BACKGROUND", BTN_BG[1], BTN_BG[2], BTN_BG[3], 0.6)
    b.bg:SetAllPoints()
    b.border = EBorder(b, 1, 1, 1, 0.3)
    b.label = EFont(b, size or 12, 0.55)
    b.label:SetPoint("CENTER")
    b.label:SetText(text)
    b:SetScript("OnEnter", function()
        b.bg:SetColorTexture(BTN_BG[1], BTN_BG[2], BTN_BG[3], 0.65)
        b.border:SetColor(1, 1, 1, 0.45)
        b.label:SetTextColor(1, 1, 1, 0.70)
    end)
    b:SetScript("OnLeave", function()
        b.bg:SetColorTexture(BTN_BG[1], BTN_BG[2], BTN_BG[3], 0.6)
        b.border:SetColor(1, 1, 1, 0.3)
        b.label:SetTextColor(1, 1, 1, 0.55)
    end)
    b:SetScript("OnClick", onClick)
    return b
end

-- Lista scrollabile con scrollbar custom 4px (pattern EllesmereUI)
local function EScrollList(parent)
    local sf = CreateFrame("ScrollFrame", nil, parent)
    sf:EnableMouseWheel(true)
    sf:SetClipsChildren(true)
    local child = CreateFrame("Frame", nil, sf)
    child:SetSize(1, 1)
    sf:SetScrollChild(child)
    sf.child = child

    local track = CreateFrame("Frame", nil, sf)
    track:SetWidth(4)
    track:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -2, -2)
    track:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", -2, 2)
    ETex(track, "BACKGROUND", 1, 1, 1, 0.02):SetAllPoints(track)
    local thumb = CreateFrame("Button", nil, track)
    thumb:SetWidth(4)
    ETex(thumb, "ARTWORK", 1, 1, 1, 0.27):SetAllPoints(thumb)

    local function MaxScroll()
        return math.max(0, child:GetHeight() - sf:GetHeight())
    end
    local function UpdateThumb()
        local ms = MaxScroll()
        if ms <= 0 then
            track:Hide()
            sf:SetVerticalScroll(0)
            return
        end
        track:Show()
        -- Clamp: se il contenuto si accorcia (ricerca, delete) l'offset vecchio
        -- può superare il nuovo massimo e la lista renderebbe vuota
        local cur = sf:GetVerticalScroll()
        if cur > ms then
            sf:SetVerticalScroll(ms)
            cur = ms
        end
        local trackH, visH = track:GetHeight(), sf:GetHeight()
        local th = math.max(20, trackH * visH / (visH + ms))
        thumb:SetHeight(th)
        thumb:ClearAllPoints()
        thumb:SetPoint("TOP", track, "TOP", 0, -((cur / ms) * (trackH - th)))
    end
    sf.UpdateThumb = UpdateThumb

    sf:SetScript("OnMouseWheel", function(self, delta)
        local ms = MaxScroll()
        if ms <= 0 then return end
        self:SetVerticalScroll(math.max(0, math.min(ms, self:GetVerticalScroll() - delta * 42)))
        UpdateThumb()
    end)
    thumb:SetScript("OnMouseDown", function(self, button)
        if button ~= "LeftButton" then return end
        local _, cy0 = GetCursorPosition()
        local startY = cy0 / self:GetEffectiveScale()
        local startScroll = sf:GetVerticalScroll()
        self:SetScript("OnUpdate", function(s)
            if not IsMouseButtonDown("LeftButton") then s:SetScript("OnUpdate", nil) return end
            local _, cy = GetCursorPosition()
            cy = cy / s:GetEffectiveScale()
            local maxTravel = track:GetHeight() - s:GetHeight()
            if maxTravel <= 0 then return end
            local ms = MaxScroll()
            sf:SetVerticalScroll(math.max(0, math.min(ms, startScroll + ((startY - cy) / maxTravel) * ms)))
            UpdateThumb()
        end)
    end)
    thumb:SetScript("OnMouseUp", function(self) self:SetScript("OnUpdate", nil) end)
    return sf
end

-- ---------------------------------------------------------------------------
-- Dialog flat riusabile (sostituisce gli StaticPopup): testo, editbox
-- opzionale, fino a 3 bottoni. Invio = conferma, Esc = chiudi.
-- ---------------------------------------------------------------------------

local dialogFrame

local function ShowDialog(opts)
    if not dialogFrame then
        local d = CreateFrame("Frame", "OpenerTrainerDialog", UIParent)
        dialogFrame = d
        d:SetSize(400, 150)
        d:SetPoint("CENTER", 0, 140)
        d:SetFrameStrata("FULLSCREEN_DIALOG")
        d:EnableMouse(true)
        d:EnableKeyboard(true)
        d:SetScript("OnKeyDown", function(s, key)
            if key == "ESCAPE" then
                s:SetPropagateKeyboardInput(false)
                s:Hide()
            else
                s:SetPropagateKeyboardInput(true)
            end
        end)
        ETex(d, "BACKGROUND", PANEL_BG[1], PANEL_BG[2], PANEL_BG[3], 0.97):SetAllPoints(d)
        EBorder(d, 1, 1, 1, 0.2)

        d.text = EFont(d, 13, 0.9)
        d.text:SetPoint("TOPLEFT", 16, -16)
        d.text:SetPoint("TOPRIGHT", -16, -16)
        d.text:SetJustifyH("LEFT")
        d.text:SetWordWrap(true)

        d.edit = CreateFrame("EditBox", nil, d)
        d.edit:SetHeight(24)
        d.edit:SetPoint("TOPLEFT", d.text, "BOTTOMLEFT", 0, -12)
        d.edit:SetPoint("RIGHT", d, "RIGHT", -16, 0)
        d.edit:SetFont(EDITOR_FONT, 12, "")
        d.edit:SetTextColor(1, 1, 1, 0.9)
        d.edit:SetAutoFocus(false)
        d.edit:SetTextInsets(6, 6, 0, 0)
        d.edit:SetJustifyH("LEFT")
        ETex(d.edit, "BACKGROUND", 0, 0, 0, 0.4):SetAllPoints(d.edit)
        EBorder(d.edit, 1, 1, 1, 0.10)
        d.edit:SetScript("OnEscapePressed", function() d:Hide() end)
        d.edit:SetScript("OnEnterPressed", function()
            if d.onAccept then d.onAccept() end
        end)

        d.buttons = {}
        for i = 1, 3 do
            d.buttons[i] = EButton(d, 92, 24, "", 12, nil)
        end
    end

    local d = dialogFrame
    d.text:SetText(opts.text or "")
    local hasEdit = opts.hasEdit and true or false
    d.edit:SetShown(hasEdit)
    if hasEdit then
        d.edit:SetText(opts.editText or "")
    end

    local function EditText()
        return hasEdit and (d.edit:GetText() or "") or nil
    end
    d.onAccept = function()
        d:Hide()
        if opts.acceptFn then opts.acceptFn(EditText()) end
    end

    -- bottoni da destra a sinistra: [annulla] [alt] [conferma]
    local defs = {}
    defs[#defs + 1] = { label = opts.acceptText or OKAY, fn = d.onAccept }
    if opts.altText then
        defs[#defs + 1] = {
            label = opts.altText,
            fn = function()
                d:Hide()
                if opts.altFn then opts.altFn(EditText()) end
            end,
        }
    end
    if not opts.noCancel then
        defs[#defs + 1] = { label = opts.cancelText or CANCEL, fn = function() d:Hide() end }
    end
    local anchorX = -16
    for i = 1, 3 do
        local b = d.buttons[i]
        local def = defs[#defs - i + 1] -- inverti: l'ultimo (annulla) a destra
        if def then
            b.label:SetText(def.label)
            b:SetScript("OnClick", def.fn)
            b:ClearAllPoints()
            b:SetPoint("BOTTOMRIGHT", anchorX, 12)
            anchorX = anchorX - 98
            b:Show()
        else
            b:Hide()
        end
    end

    local textH = math.max(20, d.text:GetStringHeight() or 20)
    d:SetHeight(16 + textH + (hasEdit and 38 or 8) + 50)
    d:Show()
    if hasEdit then
        d.edit:SetFocus()
        if opts.selectAll then d.edit:HighlightText() end
    end
end

-- ---------------------------------------------------------------------------
-- Menu condiviso di scelta opener (usato da tracker, barra ed editor)
-- ---------------------------------------------------------------------------

local openerMenu
local openerMenuButtons = {}

local function HideOpenerMenu()
    if openerMenu then openerMenu:Hide() end
end

local MENU_ITEM_H = 24

local function ToggleOpenerMenu(anchor, growUp)
    if not openerMenu then
        openerMenu = CreateFrame("Frame", "OpenerTrainerMenu", UIParent)
        ETex(openerMenu, "BACKGROUND", DD_BG[1], DD_BG[2], DD_BG[3], 0.98):SetAllPoints(openerMenu)
        EBorder(openerMenu, 1, 1, 1, 0.2)
        openerMenu:SetFrameStrata("TOOLTIP")
        openerMenu:EnableMouse(true)
        openerMenu:Hide()
        -- chiusura click-away (pattern dropdown EllesmereUI)
        openerMenu:SetScript("OnShow", function(self)
            self:SetScript("OnUpdate", function(m)
                if not m:IsMouseOver() and IsMouseButtonDown("LeftButton")
                    and not (m.anchor and m.anchor:IsMouseOver()) then
                    m:Hide()
                end
            end)
        end)
        openerMenu:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)
    end
    if openerMenu:IsShown() and openerMenu.anchor == anchor then
        openerMenu:Hide()
        return
    end
    local _, activeIdx, list = GetActiveOpener()
    if #list == 0 then Print(L.NO_OPENERS_SPEC) return end
    openerMenu.anchor = anchor
    for i, op in ipairs(list) do
        local btn = openerMenuButtons[i]
        if not btn then
            btn = CreateFrame("Button", nil, openerMenu)
            btn:SetSize(182, MENU_ITEM_H)
            btn:SetPoint("TOPLEFT", 4, -4 - (i - 1) * MENU_ITEM_H)
            btn:SetPoint("TOPRIGHT", -4, -4 - (i - 1) * MENU_ITEM_H)
            btn.hl = ETex(btn, "ARTWORK", 1, 1, 1, 0)
            btn.hl:SetAllPoints()
            btn.ind = ETex(btn, "OVERLAY", ACCENT.r, ACCENT.g, ACCENT.b, 1)
            btn.ind:SetPoint("TOPLEFT")
            btn.ind:SetPoint("BOTTOMLEFT")
            btn.ind:SetWidth(3)
            btn.label = EFont(btn, 13, 0.7)
            btn.label:SetPoint("LEFT", 12, 0)
            btn.label:SetPoint("RIGHT", -8, 0)
            btn.label:SetJustifyH("LEFT")
            btn.label:SetWordWrap(false)
            btn:SetScript("OnEnter", function(s)
                s.hl:SetColorTexture(1, 1, 1, 0.08)
                if s.fullName and (not s.label.IsTruncated or s.label:IsTruncated()) then
                    GameTooltip:SetOwner(s, "ANCHOR_CURSOR")
                    GameTooltip:SetText(s.fullName, 1, 1, 1, 1, true)
                    GameTooltip:Show()
                end
            end)
            btn:SetScript("OnLeave", function(s)
                s.hl:SetColorTexture(1, 1, 1, 0)
                GameTooltip:Hide()
            end)
            openerMenuButtons[i] = btn
        end
        btn.label:SetText(op.name)
        btn.fullName = op.name
        if i == activeIdx then
            btn.ind:Show()
            btn.label:SetTextColor(ACCENT.r, ACCENT.g, ACCENT.b, 1)
        else
            btn.ind:Hide()
            btn.label:SetTextColor(1, 1, 1, 0.7)
        end
        btn:SetScript("OnClick", function()
            local _, _, l, spec = GetActiveOpener()
            if l[i] then db.active[spec] = i end
            openerMenu:Hide()
            ResetRun()
            Tracker_Refresh()
            Editor_RefreshHeader()
            Editor_RefreshSteps()
        end)
        btn:Show()
    end
    for i = #list + 1, #openerMenuButtons do openerMenuButtons[i]:Hide() end
    openerMenu:SetSize(190, 8 + #list * MENU_ITEM_H)
    openerMenu:ClearAllPoints()
    if growUp then
        openerMenu:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 2)
    else
        openerMenu:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -2)
    end
    openerMenu:Show()
end

-- Match con gestione override (es. DH: Blade Dance -> Death Sweep in Metamorphosis)
local function StepMatches(step, castID)
    local sid = step.spellID
    if not sid then return false end
    if sid == castID then return true end
    if C_Spell and C_Spell.GetOverrideSpell then
        local ok, o = pcall(C_Spell.GetOverrideSpell, sid)
        if ok and ScrubID(o) == castID then return true end
        ok, o = pcall(C_Spell.GetOverrideSpell, castID)
        if ok and ScrubID(o) == sid then return true end
    end
    if C_SpellBook and C_SpellBook.FindSpellOverrideByID then
        local ok, o = pcall(C_SpellBook.FindSpellOverrideByID, sid)
        if ok and ScrubID(o) == castID then return true end
    end
    -- Fallback per ID divergenti (seed, varianti): confronto per nome
    local n1, n2 = GetSpellName(sid), GetSpellName(castID)
    if n1 and n2 and n1:lower() == n2:lower() then return true end
    return false
end

-- Rosso SOLO per spell talentabili non selezionate nell'albero corrente.
-- Tutto ciò che non è un nodo dell'albero (forme override, spell base) non
-- viene mai giudicato: meglio nessun avviso che un falso rosso.
local function StepKnown(spellID)
    if not spellID then return true end
    local function try(fn, id)
        if type(fn) ~= "function" then return false end
        local ok, r = pcall(fn, id)
        return (ok and r) and true or false
    end
    if try(IsSpellKnownOrOverridesKnown, spellID) then return true end
    if try(IsPlayerSpell, spellID) then return true end
    if C_SpellBook and try(C_SpellBook.IsSpellKnown, spellID) then return true end
    if talentSelected and talentSelected[spellID] == false then
        return false -- nodo del talent tree esistente ma non selezionato
    end
    return true
end

local function OnPlayerCast(spellID)
    spellID = ScrubID(spellID)
    if not spellID then return end
    -- Ogni cast riuscito entra nel pool del picker: le forme override si
    -- registrano al primo uso reale, per sempre
    if db and db.spellPool then db.spellPool[spellID] = true end
    local opener = GetActiveOpener()
    if not opener then return end
    local steps = opener.steps
    AdvancePastInfo(steps)
    if run.pointer > #steps then return end
    local step = steps[run.pointer]
    if not step or not StepMatches(step, spellID) then return end

    local now = GetTime()
    local delta = run.lastCastTime and (now - run.lastCastTime) or 0
    run.lastCastTime = now
    run.castsInStep = run.castsInStep + 1

    -- Il delta mostrato è SEMPRE "distanza dal cast precedente al primo cast di
    -- questo step"; per step x2/x3 il tempo tra i cast interni finisce in intra.
    if run.castsInStep == 1 then
        run.deltas[run.pointer] = delta
        run.stepStart = now
    else
        run.intra[run.pointer] = now - (run.stepStart or now)
    end

    if run.castsInStep >= (step.count or 1) then
        run.done[run.pointer] = true
        run.pointer = run.pointer + 1
        run.castsInStep = 0
        run.stepStart = nil
        AdvancePastInfo(steps)
    end
    Tracker_Refresh()
end

-- ---------------------------------------------------------------------------
-- Seed: opener predefinite per Havoc DH (spec 577), dalle guide dell'utente.
-- Create SOLO se la spec non ha ancora opener e mai più di una volta
-- (db.seeded): cancellarle non le fa risorgere.
-- ---------------------------------------------------------------------------

local HAVOC_SPEC_ID = 577

local SEED_OPENERS = {
    {
        name = "Aldrachi Raid",
        steps = {
            { name = "Immolation Aura", id = 258920, label = "Immolation Aura (pre-pull 1.5s)" },
            { name = "The Hunt", id = 370965 },
            { info = "Pot + Items" },
            { name = "Reaver's Glaive", id = 442294 },
            { name = "Eye Beam", id = 198013 },
            { name = "Essence Break", id = 258860 },
            { name = "Death Sweep", id = 210152 },
            { name = "Annihilation", id = 201427 },
            { name = "Death Sweep", id = 210152 },
            { name = "Vengeful Retreat", id = 198793, label = "Vengeful Retreat + Meta" },
            { name = "Death Sweep", id = 210152 },
            { name = "Eye Beam", id = 198013 },
        },
    },
    {
        name = "Fel-Scarred M+",
        steps = {
            { name = "Throw Glaive", id = 185123, label = "Throw Glaive (grouping)" },
            { name = "Immolation Aura", id = 258920, count = 2 },
            { info = "Pot + Items" },
            { name = "Eye Beam", id = 198013 },
            { name = "The Hunt", id = 370965 },
            { name = "Essence Break", id = 258860 },
            { name = "Death Sweep", id = 210152, count = 2 },
            { name = "Annihilation", id = 201427 },
            { name = "Vengeful Retreat", id = 198793, label = "Vengeful Retreat + Meta" },
            { name = "Death Sweep", id = 210152 },
            { name = "Immolation Aura", id = 258920 },
            { name = "Annihilation", id = 201427 },
            { name = "Eye Beam", id = 198013 },
            { name = "Immolation Aura", id = 258920 },
        },
    },
}

local function SeedDefaults()
    local spec = GetCurrentSpecID()
    if spec ~= HAVOC_SPEC_ID then return end
    db.seeded = db.seeded or {}
    if db.seeded[spec] then return end
    db.openers[spec] = db.openers[spec] or {}
    local list = db.openers[spec]
    if #list > 0 then
        db.seeded[spec] = true
        return
    end
    -- Risolvi i nomi sullo spellbook reale del personaggio; fallback: ID noti.
    local byName = {}
    for _, s in ipairs(EnumerateKnownSpells()) do
        if s.name then byName[s.name:lower()] = s.spellID end
    end
    for _, seed in ipairs(SEED_OPENERS) do
        local steps = {}
        for _, st in ipairs(seed.steps) do
            if st.info then
                steps[#steps + 1] = { kind = "info", label = st.info }
            else
                steps[#steps + 1] = {
                    kind = "spell",
                    spellID = byName[st.name:lower()] or st.id,
                    count = st.count or 1,
                    label = st.label,
                }
            end
        end
        list[#list + 1] = { name = seed.name, steps = steps }
    end
    db.active[spec] = 1
    db.seeded[spec] = true
    ResetRun()
    Tracker_Refresh()
    Print(L.SEEDED)
end

-- ---------------------------------------------------------------------------
-- Tracker: UI
-- ---------------------------------------------------------------------------

local tracker
local trackerRows = {}
local bar
local barIcons = {}

local ROW_H = 20
local TRACKER_W = 250

local function SaveTrackerPos()
    local point, _, relPoint, x, y = tracker:GetPoint(1)
    db.framePos = { point = point, relPoint = relPoint, x = x, y = y }
end

local function AcquireTrackerRow(i)
    local row = trackerRows[i]
    if row then return row end
    row = CreateFrame("Frame", nil, tracker)
    row:SetHeight(ROW_H)
    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetSize(16, 16)
    row.icon:SetPoint("LEFT", row, "LEFT", 0, 0)
    row.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    row.name = EFont(row, 13, 1)
    row.name:SetPoint("LEFT", row.icon, "RIGHT", 5, 0)
    row.name:SetJustifyH("LEFT")
    row.name:SetWordWrap(false)
    row.delta = EFont(row, 11, 1)
    row.delta:SetPoint("RIGHT", row, "RIGHT", 0, 0)
    row.delta:SetJustifyH("RIGHT")
    row.name:SetPoint("RIGHT", row.delta, "LEFT", -4, 0)

    -- Tooltip; il drag partito da una riga muove il tracker
    row:EnableMouse(true)
    row:RegisterForDrag("LeftButton")
    row:SetScript("OnDragStart", function() tracker:StartMoving() end)
    row:SetScript("OnDragStop", function()
        tracker:StopMovingOrSizing()
        SaveTrackerPos()
    end)
    row:SetScript("OnEnter", function(self)
        local step = self.step
        if not step then return end
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        if step.kind == "info" then
            GameTooltip:SetText(step.label or "Info")
            GameTooltip:AddLine(L.INFO_STEP_TT, 0.6, 0.9, 1)
        elseif step.spellID then
            pcall(GameTooltip.SetSpellByID, GameTooltip, step.spellID)
            if self.missing then
                GameTooltip:AddLine(L.NOT_TALENTED, 1, 0.3, 0.3)
            end
        end
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end)

    trackerRows[i] = row
    return row
end

-- Piccolo bottone flat solo-testo (X, freccia, reset) per le finestre compatte
local function EGlyphButton(parent, size, glyph, fontSize, hoverR, hoverG, hoverB, onClick)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(size, size)
    b.label = EFont(b, fontSize, 0.55)
    b.label:SetPoint("CENTER")
    b.label:SetText(glyph)
    b:SetScript("OnEnter", function(s) s.label:SetTextColor(hoverR, hoverG, hoverB, 1) end)
    b:SetScript("OnLeave", function(s) s.label:SetTextColor(1, 1, 1, 0.55) end)
    b:SetScript("OnClick", onClick)
    return b
end

local function BuildTracker()
    tracker = CreateFrame("Frame", "OpenerTrainerFrame", UIParent)
    tracker:SetSize(db.trackerW or TRACKER_W, 120)
    ETex(tracker, "BACKGROUND", PANEL_BG[1], PANEL_BG[2], PANEL_BG[3], 0.9):SetAllPoints(tracker)
    EBorder(tracker, 1, 1, 1, 0.12)
    tracker:SetMovable(true)
    tracker:EnableMouse(true)
    tracker:SetClampedToScreen(true)
    tracker:RegisterForDrag("LeftButton")
    tracker:SetScript("OnDragStart", tracker.StartMoving)
    tracker:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        SaveTrackerPos()
    end)

    tracker.title = EFont(tracker, 15, 1)
    tracker.title:SetPoint("TOPLEFT", 12, -10)
    tracker.title:SetText("|cff0cd29dOpener|rTrainer")
    local underline = ETex(tracker, "OVERLAY", ACCENT.r, ACCENT.g, ACCENT.b, 1)
    underline:SetPoint("TOPLEFT", tracker.title, "BOTTOMLEFT", 0, -3)
    underline:SetSize(40, 2)

    tracker.subtitle = EFont(tracker, 11, 0.53)
    tracker.subtitle:SetPoint("TOPLEFT", tracker.title, "BOTTOMLEFT", 0, -9)
    tracker.subtitle:SetPoint("RIGHT", tracker, "RIGHT", -28, 0)
    tracker.subtitle:SetJustifyH("LEFT")
    tracker.subtitle:SetWordWrap(false)

    -- Nome opener troncato: tooltip col nome completo agganciato al cursore
    local nameHover = CreateFrame("Frame", nil, tracker)
    nameHover:SetPoint("TOPLEFT", tracker.subtitle, "TOPLEFT", 0, 2)
    nameHover:SetPoint("BOTTOMRIGHT", tracker.subtitle, "BOTTOMRIGHT", 0, -2)
    nameHover:EnableMouse(true)
    nameHover:RegisterForDrag("LeftButton")
    nameHover:SetScript("OnDragStart", function() tracker:StartMoving() end)
    nameHover:SetScript("OnDragStop", function()
        tracker:StopMovingOrSizing()
        SaveTrackerPos()
    end)
    nameHover:SetScript("OnEnter", function(s)
        local opener = GetActiveOpener()
        if not opener then return end
        if tracker.subtitle.IsTruncated and not tracker.subtitle:IsTruncated() then return end
        GameTooltip:SetOwner(s, "ANCHOR_CURSOR")
        GameTooltip:SetText(opener.name, 1, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    nameHover:SetScript("OnLeave", function() GameTooltip:Hide() end)

    tracker.closeBtn = EGlyphButton(tracker, 20, "X", 13, 1, 0.35, 0.35, function()
        tracker:Hide()
        db.hidden = true
    end)
    tracker.closeBtn:SetPoint("TOPRIGHT", -4, -4)

    -- Dropdown scelta opener accanto al nome
    tracker.selBtn = EGlyphButton(tracker, 18, "v", 11, ACCENT.r, ACCENT.g, ACCENT.b, function()
        ToggleOpenerMenu(tracker.selBtn, false)
    end)
    tracker.selBtn:SetPoint("TOPRIGHT", tracker, "TOPRIGHT", -6, -26)

    tracker.resetBtn = EButton(tracker, 72, 20, L.RESET, 12, function()
        ResetRun()
        Tracker_Refresh()
    end)
    tracker.resetBtn:SetPoint("BOTTOMLEFT", 10, 8)

    tracker.editBtn = EButton(tracker, 72, 20, L.EDITOR, 12, nil)
    tracker.editBtn:SetPoint("BOTTOMRIGHT", -10, 8)

    -- Ridimensionamento orizzontale: grip nell'angolo in basso a destra
    tracker:SetResizable(true)
    if tracker.SetResizeBounds then tracker:SetResizeBounds(TRACKER_W, 100, 620, 1400) end
    local grip = CreateFrame("Button", nil, tracker)
    grip:SetSize(16, 16)
    grip:SetPoint("BOTTOMRIGHT", -1, 1)
    grip:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    grip:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    grip:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    grip:SetScript("OnMouseDown", function() tracker:StartSizing("RIGHT") end)
    grip:SetScript("OnMouseUp", function()
        tracker:StopMovingOrSizing()
        db.trackerW = math.floor(tracker:GetWidth() + 0.5)
        SaveTrackerPos()
        Tracker_Refresh()
    end)

    if db.framePos then
        tracker:ClearAllPoints()
        tracker:SetPoint(db.framePos.point or "CENTER", UIParent, db.framePos.relPoint or "CENTER",
            db.framePos.x or 0, db.framePos.y or 0)
    else
        tracker:SetPoint("RIGHT", UIParent, "RIGHT", -80, 60)
    end
    if db.hidden then tracker:Hide() end
end

function Tracker_Refresh()
    if not tracker then return end
    local opener = GetActiveOpener()
    local steps = opener and opener.steps or {}

    tracker.subtitle:SetText(opener and opener.name or ("|cffaaaaaa" .. L.NO_OPENER_HINT .. "|r"))

    for i, step in ipairs(steps) do
        local row = AcquireTrackerRow(i)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", tracker, "TOPLEFT", 10, -52 - (i - 1) * ROW_H)
        row:SetPoint("RIGHT", tracker, "RIGHT", -10, 0)
        row:Show()

        local label, icon
        if step.kind == "info" then
            label = step.label or "Info"
            icon = step.icon or ICON_INFO
        else
            label = step.label or GetSpellName(step.spellID)
            if (step.count or 1) > 1 then label = label .. " x" .. step.count end
            icon = GetSpellIcon(step.spellID)
        end
        row.icon:SetTexture(icon)
        row.name:SetText(label)

        local missing = step.kind ~= "info" and not StepKnown(step.spellID)
        row.step, row.missing = step, missing

        local c
        if missing then
            c = COLOR_MISSING
        elseif step.kind == "info" or run.done[i] then
            c = COLOR_DONE
        elseif i == run.pointer then
            c = COLOR_CURRENT
        else
            c = COLOR_PENDING
        end
        row.name:SetTextColor(c[1], c[2], c[3])

        if step.kind == "info" then
            row.delta:SetText("|cff55dd55—|r")
        elseif run.done[i] then
            if run.intra[i] then
                row.delta:SetFormattedText("|cff55dd55+%.2fs (%.2fs)|r", run.deltas[i] or 0, run.intra[i])
            else
                row.delta:SetFormattedText("|cff55dd55+%.2fs|r", run.deltas[i] or 0)
            end
        elseif i == run.pointer and (step.count or 1) > 1 and run.castsInStep > 0 then
            row.delta:SetFormattedText("|cffffee55%d/%d|r", run.castsInStep, step.count)
        else
            row.delta:SetText("")
        end
    end
    for i = #steps + 1, #trackerRows do
        trackerRows[i]:Hide()
    end

    local n = math.max(#steps, 1)
    tracker:SetHeight(52 + n * ROW_H + 34)

    Bar_Refresh()
end

-- ---------------------------------------------------------------------------
-- Barra orizzontale compatta: solo icone, da tenere sopra le action bar.
-- Verde intorno all'icona quando lo step è fatto, giallo sullo step atteso.
-- ---------------------------------------------------------------------------

local BAR_ICON = 30
local BAR_GAP = 4
local BAR_PAD_L = 28
local BAR_PAD_R = 46 -- spazio per reset + X
local BAR_H = 42

local function SaveBarPos()
    local point, _, relPoint, x, y = bar:GetPoint(1)
    db.barPos = { point = point, relPoint = relPoint, x = x, y = y }
end

local function AcquireBarIcon(i)
    local f = barIcons[i]
    if f then return f end
    f = CreateFrame("Frame", nil, bar)
    f:SetSize(BAR_ICON, BAR_ICON)
    f.border = f:CreateTexture(nil, "BACKGROUND")
    f.border:SetPoint("CENTER")
    f.border:SetSize(BAR_ICON + 4, BAR_ICON + 4)
    f.border:SetTexture("Interface\\Buttons\\WHITE8x8")
    f.icon = f:CreateTexture(nil, "ARTWORK")
    f.icon:SetAllPoints()
    f.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    f.count = f:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    f.count:SetPoint("BOTTOMRIGHT", 2, 0)

    -- Tooltip al passaggio del mouse; il drag partito da un'icona muove la barra
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function() bar:StartMoving() end)
    f:SetScript("OnDragStop", function()
        bar:StopMovingOrSizing()
        SaveBarPos()
    end)
    f:SetScript("OnEnter", function(self)
        local step = self.step
        if not step then return end
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        if step.kind == "info" then
            GameTooltip:SetText(step.label or "Info")
            GameTooltip:AddLine(L.INFO_STEP_TT, 0.6, 0.9, 1)
        elseif step.spellID then
            pcall(GameTooltip.SetSpellByID, GameTooltip, step.spellID)
            if step.label then GameTooltip:AddLine(step.label, 0.7, 0.7, 0.7) end
            if self.missing then
                GameTooltip:AddLine(L.NOT_TALENTED, 1, 0.3, 0.3)
            end
        end
        GameTooltip:Show()
    end)
    f:SetScript("OnLeave", function() GameTooltip:Hide() end)

    barIcons[i] = f
    return f
end

local function BuildBar()
    bar = CreateFrame("Frame", "OpenerTrainerBar", UIParent)
    bar:SetSize(200, BAR_H)
    ETex(bar, "BACKGROUND", PANEL_BG[1], PANEL_BG[2], PANEL_BG[3], 0.75):SetAllPoints(bar)
    EBorder(bar, 1, 1, 1, 0.12)
    bar:SetMovable(true)
    bar:EnableMouse(true)
    bar:SetClampedToScreen(true)
    bar:RegisterForDrag("LeftButton")
    bar:SetScript("OnDragStart", bar.StartMoving)
    bar:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        SaveBarPos()
    end)

    bar.selBtn = EGlyphButton(bar, 18, "v", 11, ACCENT.r, ACCENT.g, ACCENT.b, function()
        -- Il menu si apre verso l'ALTO: la barra sta sopra le action bar
        ToggleOpenerMenu(bar.selBtn, true)
    end)
    bar.selBtn:SetPoint("LEFT", 6, 0)

    bar.closeBtn = EGlyphButton(bar, 18, "X", 12, 1, 0.35, 0.35, function()
        bar:Hide()
        db.barHidden = true
    end)
    bar.closeBtn:SetPoint("RIGHT", -4, 0)

    -- Reset della run, prima della X
    bar.resetBtn = EGlyphButton(bar, 18, "«", 13, ACCENT.r, ACCENT.g, ACCENT.b, function()
        ResetRun()
        Tracker_Refresh()
    end)
    bar.resetBtn:SetPoint("RIGHT", bar.closeBtn, "LEFT", -2, 0)
    bar.resetBtn:HookScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(L.RESET)
        GameTooltip:Show()
    end)
    bar.resetBtn:HookScript("OnLeave", function() GameTooltip:Hide() end)

    if db.barPos then
        bar:ClearAllPoints()
        bar:SetPoint(db.barPos.point or "BOTTOM", UIParent, db.barPos.relPoint or "BOTTOM",
            db.barPos.x or 0, db.barPos.y or 160)
    else
        bar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 160)
    end
    if db.barHidden then bar:Hide() end
end

function Bar_Refresh()
    if not bar then return end
    local opener = GetActiveOpener()
    local steps = opener and opener.steps or {}
    for i, step in ipairs(steps) do
        local f = AcquireBarIcon(i)
        f.step = step
        f:ClearAllPoints()
        f:SetPoint("LEFT", bar, "LEFT", BAR_PAD_L + (i - 1) * (BAR_ICON + BAR_GAP), 0)
        f:Show()

        local icon
        if step.kind == "info" then
            icon = step.icon or ICON_INFO
        else
            icon = GetSpellIcon(step.spellID)
        end
        f.icon:SetTexture(icon)

        local missing = step.kind ~= "info" and not StepKnown(step.spellID)
        f.missing = missing
        local done = step.kind == "info" or run.done[i]
        local current = (i == run.pointer) and step.kind ~= "info"
        if missing then
            f.border:Show()
            f.border:SetVertexColor(0.9, 0.15, 0.15, 0.9)
            f.icon:SetDesaturated(true)
            f.icon:SetVertexColor(1, 0.35, 0.35)
        elseif done then
            f.border:Show()
            f.border:SetVertexColor(0.15, 0.9, 0.25, 0.9)
            f.icon:SetDesaturated(false)
            f.icon:SetVertexColor(1, 1, 1)
        elseif current then
            f.border:Show()
            f.border:SetVertexColor(1, 0.85, 0.15, 0.9)
            f.icon:SetDesaturated(false)
            f.icon:SetVertexColor(1, 1, 1)
        else
            f.border:Hide()
            f.icon:SetDesaturated(true)
            f.icon:SetVertexColor(0.55, 0.55, 0.55)
        end

        local c = step.count or 1
        if c > 1 and not done then
            if current and run.castsInStep > 0 then
                f.count:SetFormattedText("%d/%d", run.castsInStep, c)
            else
                f.count:SetFormattedText("x%d", c)
            end
            f.count:Show()
        else
            f.count:Hide()
        end
    end
    for i = #steps + 1, #barIcons do barIcons[i]:Hide() end

    local n = #steps
    local w = BAR_PAD_L + (n > 0 and (n * (BAR_ICON + BAR_GAP) - BAR_GAP) or 40) + BAR_PAD_R
    bar:SetWidth(w)
end

-- ---------------------------------------------------------------------------
-- Editor: UI in stile EllesmereUI — flat, scuro, accent teal, ZERO template
-- Blizzard. Pattern estratti dal sorgente EllesmereUI: texture piatte via
-- SetColorTexture, bordi 1px a 4 strisce (no BackdropTemplate), testo bianco
-- a livelli di alpha, zebra rows, scrollbar custom 4px, drag&drop manuale
-- con linea di inserimento accent.
-- ---------------------------------------------------------------------------

local editor
local EDITOR_W, EDITOR_H = 780, 500
local ED_SIDEBAR_W = 150
local ED_HEADER_H = 40
local ED_FOOTER_H = 44
local SPELL_ROW_H = 26
local STEP_ROW_H = 28
local SIDE_ROW_H = 30

local sideRows, editorSpellRows, editorStepRows = {}, {}, {}
local knownSpells = {}

local function CurrentSearch()
    if not (editor and editor.search) then return "" end
    return (editor.search:GetText() or ""):lower()
end

local function AddStep(step)
    local opener = GetActiveOpener()
    if not opener then
        Print(L.CREATE_FIRST)
        return
    end
    opener.steps[#opener.steps + 1] = step
    ResetRun()
    Tracker_Refresh()
    Editor_RefreshSteps()
end

-- Import condiviso (dialog Import + preset): crea l'opener nella spec data
local function DoImportString(text, spec)
    local ok, opener, skipped = pcall(ImportOpener, text or "")
    if not ok or not opener then
        Print(L.IMPORT_BAD)
        return
    end
    db.openers[spec] = db.openers[spec] or {}
    local list = db.openers[spec]
    list[#list + 1] = opener
    db.active[spec] = #list
    ResetRun()
    Tracker_Refresh()
    Editor_RefreshAll()
    Print(L.IMPORT_OK:format(opener.name, #opener.steps, skipped or 0))
    if opener.talents then Print(L.IMPORT_TALENTS_NOTE) end
end

-- Menu dei preset (da Presets.lua) per la spec corrente
local presetMenu
local presetMenuButtons = {}

local function TogglePresetMenu(anchor)
    local list = _G.OPENERTRAINER_PRESETS and _G.OPENERTRAINER_PRESETS[GetCurrentSpecID()]
    if not list or #list == 0 then
        Print(L.NO_PRESETS)
        return
    end
    if not presetMenu then
        presetMenu = CreateFrame("Frame", nil, UIParent)
        ETex(presetMenu, "BACKGROUND", DD_BG[1], DD_BG[2], DD_BG[3], 0.98):SetAllPoints(presetMenu)
        EBorder(presetMenu, 1, 1, 1, 0.2)
        presetMenu:SetFrameStrata("FULLSCREEN_DIALOG")
        presetMenu:EnableMouse(true)
        presetMenu:Hide()
        presetMenu:SetScript("OnShow", function(self)
            self:SetScript("OnUpdate", function(pm)
                if not pm:IsMouseOver() and IsMouseButtonDown("LeftButton")
                    and not (pm.anchor and pm.anchor:IsMouseOver()) then
                    pm:Hide()
                end
            end)
        end)
        presetMenu:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)
    end
    if presetMenu:IsShown() then
        presetMenu:Hide()
        return
    end
    presetMenu.anchor = anchor
    for i, p in ipairs(list) do
        local btn = presetMenuButtons[i]
        if not btn then
            btn = CreateFrame("Button", nil, presetMenu)
            btn:SetHeight(24)
            btn:SetPoint("TOPLEFT", 4, -4 - (i - 1) * 24)
            btn:SetPoint("TOPRIGHT", -4, -4 - (i - 1) * 24)
            btn.hl = ETex(btn, "ARTWORK", 1, 1, 1, 0)
            btn.hl:SetAllPoints()
            btn.label = EFont(btn, 13, 0.7)
            btn.label:SetPoint("LEFT", 12, 0)
            btn.label:SetPoint("RIGHT", -8, 0)
            btn.label:SetJustifyH("LEFT")
            btn.label:SetWordWrap(false)
            btn:SetScript("OnEnter", function(s)
                s.hl:SetColorTexture(1, 1, 1, 0.08)
                if s.fullName and (not s.label.IsTruncated or s.label:IsTruncated()) then
                    GameTooltip:SetOwner(s, "ANCHOR_CURSOR")
                    GameTooltip:SetText(s.fullName, 1, 1, 1, 1, true)
                    GameTooltip:Show()
                end
            end)
            btn:SetScript("OnLeave", function(s)
                s.hl:SetColorTexture(1, 1, 1, 0)
                GameTooltip:Hide()
            end)
            presetMenuButtons[i] = btn
        end
        btn.label:SetText(p.name)
        btn.fullName = p.name
        btn:SetScript("OnClick", function()
            presetMenu:Hide()
            DoImportString(p.import, GetCurrentSpecID())
        end)
        btn:Show()
    end
    for i = #list + 1, #presetMenuButtons do presetMenuButtons[i]:Hide() end
    presetMenu:SetSize(250, 8 + #list * 24)
    presetMenu:ClearAllPoints()
    presetMenu:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 4)
    presetMenu:Show()
end

-- Pool del picker: spellbook + spell dell'albero talenti (anche quelle NON
-- selezionate) + pool persistente delle forme già viste. avail=false -> rossa.
local function BuildPickerPool()
    local out = EnumerateKnownSpells()
    local seen, seenNames = {}, {}
    for _, s in ipairs(out) do
        seen[s.spellID] = true
        if s.name then seenNames[s.name:lower()] = true end
        s.avail = true
    end
    local function AddExtra(sid)
        sid = tonumber(sid)
        if not sid or seen[sid] then return end
        if C_Spell and C_Spell.IsSpellPassive then
            local okP, passive = pcall(C_Spell.IsSpellPassive, sid)
            if okP and passive then return end
        end
        local ok, info = pcall(C_Spell.GetSpellInfo, sid)
        if not (ok and type(info) == "table" and info.name) then return end
        if PickerBlacklisted(sid, info.name) then return end
        if seenNames[info.name:lower()] then return end -- stessa spell, ID variante
        seen[sid] = true
        seenNames[info.name:lower()] = true
        out[#out + 1] = {
            spellID = sid,
            name = info.name,
            icon = info.iconID,
            avail = StepKnown(sid),
        }
    end
    if talentSelected then
        for sid in pairs(talentSelected) do AddExtra(sid) end
    end
    if db and db.spellPool then
        for sid in pairs(db.spellPool) do AddExtra(sid) end
    end
    -- Le spell già presenti negli step di QUALUNQUE opener (tutte le spec):
    -- copre subito le forme override dei seed (Death Sweep, Annihilation...)
    if db and db.openers then
        for _, list in pairs(db.openers) do
            for _, op in ipairs(list) do
                for _, step in ipairs(op.steps or {}) do
                    if step.kind ~= "info" then AddExtra(step.spellID) end
                end
            end
        end
    end
    table.sort(out, function(a, b) return (a.name or "") < (b.name or "") end)
    return out
end

-- ---------------------------------------------------------------------------
-- Drag & drop: ghost che segue il cursore + linea di inserimento accent 2px
-- (pattern del reorder di EllesmereUI: drag manuale, soglia in pixel)
-- ---------------------------------------------------------------------------

local dragState -- { kind = "new"|"move", spellID = ?, fromIndex = ? }
local ghost, insLine

local function EnsureGhost()
    if ghost then return ghost end
    ghost = CreateFrame("Frame", nil, UIParent)
    ghost:SetSize(170, 24)
    ghost:SetFrameStrata("TOOLTIP")
    ETex(ghost, "BACKGROUND", DD_BG[1], DD_BG[2], DD_BG[3], 0.95):SetAllPoints(ghost)
    EBorder(ghost, ACCENT.r, ACCENT.g, ACCENT.b, 0.8)
    ghost.icon = ghost:CreateTexture(nil, "ARTWORK")
    ghost.icon:SetSize(18, 18)
    ghost.icon:SetPoint("LEFT", 4, 0)
    ghost.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    ghost.label = EFont(ghost, 12, 0.9)
    ghost.label:SetPoint("LEFT", ghost.icon, "RIGHT", 6, 0)
    ghost.label:SetPoint("RIGHT", -4, 0)
    ghost.label:SetJustifyH("LEFT")
    ghost.label:SetWordWrap(false)
    ghost:Hide()
    return ghost
end

-- Indice di inserimento (0..n) sotto il cursore, o nil se fuori dalla lista
local function StepsDropIndex()
    local sf = editor and editor.stepScroll
    if not (sf and sf:IsMouseOver()) then return nil end
    local child = sf.child
    local top = child:GetTop()
    if not top then return nil end
    local _, cy = GetCursorPosition()
    cy = cy / child:GetEffectiveScale()
    local opener = GetActiveOpener()
    local n = opener and #opener.steps or 0
    local idx = math.floor((top - cy) / STEP_ROW_H + 0.5)
    return math.max(0, math.min(n, idx))
end

local function UpdateDragVisuals()
    local g = EnsureGhost()
    local scale = UIParent:GetEffectiveScale()
    local cx, cy = GetCursorPosition()
    g:ClearAllPoints()
    g:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cx / scale + 14, cy / scale - 14)
    local idx = StepsDropIndex()
    if idx then
        insLine:Show()
        insLine:ClearAllPoints()
        insLine:SetPoint("TOPLEFT", editor.stepScroll.child, "TOPLEFT", 0, -(idx * STEP_ROW_H) + 1)
        insLine:SetPoint("TOPRIGHT", editor.stepScroll.child, "TOPRIGHT", -8, -(idx * STEP_ROW_H) + 1)
    else
        insLine:Hide()
    end
end

local function FinishDrag()
    if ghost then ghost:Hide() end
    if insLine then insLine:Hide() end
    local st = dragState
    dragState = nil
    if not st then return end
    local idx = StepsDropIndex()
    if not idx then return end
    local opener = GetActiveOpener()
    if not opener then return end
    -- Se l'opener attiva è cambiata a metà drag (cambio spec/selezione),
    -- gli indici non hanno più senso: annulla il drop
    if st.opener and st.opener ~= opener then return end
    local steps = opener.steps
    if st.kind == "new" then
        table.insert(steps, idx + 1, { kind = "spell", spellID = st.spellID, count = 1 })
    elseif st.kind == "move" then
        local from = st.fromIndex
        if not steps[from] then return end
        local target = idx + 1
        local step = table.remove(steps, from)
        if target > from then target = target - 1 end
        target = math.max(1, math.min(#steps + 1, target))
        table.insert(steps, target, step)
    end
    ResetRun()
    Tracker_Refresh()
    Editor_RefreshSteps()
end

-- Avvia il drag manuale da una riga: soglia 6px, poi ghost + driver OnUpdate
local function WireDrag(row, makeState, fillGhost)
    row:SetScript("OnMouseDown", function(s, button)
        if button ~= "LeftButton" then return end
        local px, py = GetCursorPosition()
        s:SetScript("OnUpdate", function(s2)
            if not IsMouseButtonDown("LeftButton") then s2:SetScript("OnUpdate", nil) return end
            local cx, cy = GetCursorPosition()
            if math.abs(cx - px) + math.abs(cy - py) > 6 then
                s2:SetScript("OnUpdate", nil)
                dragState = makeState(s2)
                if not dragState then return end
                local g = EnsureGhost()
                fillGhost(g, s2)
                g:Show()
                UpdateDragVisuals()
                g:SetScript("OnUpdate", function(gf)
                    if not IsMouseButtonDown("LeftButton") then
                        gf:SetScript("OnUpdate", nil)
                        FinishDrag()
                        return
                    end
                    UpdateDragVisuals()
                end)
            end
        end)
    end)
    row:HookScript("OnMouseUp", function(s)
        s:SetScript("OnUpdate", nil)
    end)
end

-- ---------------------------------------------------------------------------
-- Sidebar: lista opener (una riga per opener, barra accent sulla selezionata)
-- ---------------------------------------------------------------------------

local function AcquireSideRow(i)
    local row = sideRows[i]
    if row then return row end
    row = CreateFrame("Button", nil, editor.sideScroll.child)
    row:SetHeight(SIDE_ROW_H)

    row.glow = row:CreateTexture(nil, "BACKGROUND")
    row.glow:SetAllPoints()
    row.glow:SetColorTexture(ACCENT.r, ACCENT.g, ACCENT.b, 1)
    if row.glow.SetGradient and CreateColor then
        row.glow:SetGradient("HORIZONTAL",
            CreateColor(ACCENT.r, ACCENT.g, ACCENT.b, 0.15),
            CreateColor(ACCENT.r, ACCENT.g, ACCENT.b, 0))
    else
        row.glow:SetColorTexture(ACCENT.r, ACCENT.g, ACCENT.b, 0.08)
    end
    row.glow:Hide()

    row.indicator = ETex(row, "ARTWORK", ACCENT.r, ACCENT.g, ACCENT.b, 1)
    row.indicator:SetPoint("TOPLEFT")
    row.indicator:SetPoint("BOTTOMLEFT")
    row.indicator:SetWidth(3)
    row.indicator:Hide()

    row.hover = ETex(row, "ARTWORK", 1, 1, 1, 0)
    row.hover:SetAllPoints()

    row.label = EFont(row, 13, 0.6)
    row.label:SetPoint("LEFT", 12, 0)
    row.label:SetPoint("RIGHT", -8, 0)
    row.label:SetJustifyH("LEFT")
    row.label:SetWordWrap(false)

    row:SetScript("OnEnter", function(s)
        s.hover:SetColorTexture(1, 1, 1, 0.05)
        if s.fullName and (not s.label.IsTruncated or s.label:IsTruncated()) then
            GameTooltip:SetOwner(s, "ANCHOR_CURSOR")
            GameTooltip:SetText(s.fullName, 1, 1, 1, 1, true)
            GameTooltip:Show()
        end
    end)
    row:SetScript("OnLeave", function(s)
        s.hover:SetColorTexture(1, 1, 1, 0)
        GameTooltip:Hide()
    end)
    row:SetScript("OnClick", function(s)
        local _, _, list, spec = GetActiveOpener()
        if list[s.index] then
            db.active[spec] = s.index
            ResetRun()
            Tracker_Refresh()
            Editor_RefreshAll()
        end
    end)
    sideRows[i] = row
    return row
end

function Editor_RefreshHeader()
    if not editor then return end
    local _, activeIdx, list = GetActiveOpener()
    for i, op in ipairs(list) do
        local row = AcquireSideRow(i)
        row.index = i
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", editor.sideScroll.child, "TOPLEFT", 0, -(i - 1) * SIDE_ROW_H)
        row:SetPoint("TOPRIGHT", editor.sideScroll.child, "TOPRIGHT", 0, -(i - 1) * SIDE_ROW_H)
        row:Show()
        row.label:SetText(op.name)
        row.fullName = op.name
        local sel = (i == activeIdx)
        row.indicator:SetShown(sel)
        row.glow:SetShown(sel)
        row.label:SetTextColor(1, 1, 1, sel and 1 or 0.6)
    end
    for i = #list + 1, #sideRows do sideRows[i]:Hide() end
    editor.sideScroll.child:SetHeight(math.max(#list * SIDE_ROW_H, 1))
    editor.sideScroll.UpdateThumb()
end

-- ---------------------------------------------------------------------------
-- Colonna spell: ricerca + lista (click = aggiungi in coda, drag = inserisci)
-- ---------------------------------------------------------------------------

local function AcquireSpellRow(i)
    local row = editorSpellRows[i]
    if row then return row end
    row = CreateFrame("Button", nil, editor.spellScroll.child)
    row:SetHeight(SPELL_ROW_H)

    row.zebra = ETex(row, "BACKGROUND", 0, 0, 0, 0.1)
    row.zebra:SetAllPoints()
    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetSize(18, 18)
    row.icon:SetPoint("LEFT", 8, 0)
    row.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    row.label = EFont(row, 12, 0.75)
    row.label:SetPoint("LEFT", row.icon, "RIGHT", 7, 0)
    row.label:SetPoint("RIGHT", -8, 0)
    row.label:SetJustifyH("LEFT")
    row.label:SetWordWrap(false)
    row.hover = ETex(row, "ARTWORK", 1, 1, 1, 0)
    row.hover:SetAllPoints()

    row:SetScript("OnEnter", function(s)
        s.hover:SetColorTexture(1, 1, 1, 0.04)
        if s.avail == false then
            s.label:SetTextColor(1, 0.5, 0.5, 1)
        else
            s.label:SetTextColor(1, 1, 1, 1)
        end
        if s.spellID then
            GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
            pcall(GameTooltip.SetSpellByID, GameTooltip, s.spellID)
            if s.avail == false then
                GameTooltip:AddLine(L.NOT_TALENTED, 1, 0.3, 0.3)
            end
            GameTooltip:Show()
        end
    end)
    row:SetScript("OnLeave", function(s)
        s.hover:SetColorTexture(1, 1, 1, 0)
        if s.avail == false then
            s.label:SetTextColor(1, 0.4, 0.4, 0.9)
        else
            s.label:SetTextColor(1, 1, 1, 0.75)
        end
        GameTooltip:Hide()
    end)
    row:SetScript("OnClick", function(s)
        if dragState then return end -- il rilascio di un drag non è un click
        if s.spellID then
            AddStep({ kind = "spell", spellID = s.spellID, count = 1 })
        end
    end)
    WireDrag(row,
        function(s)
            if not s.spellID then return nil end
            return { kind = "new", spellID = s.spellID, opener = GetActiveOpener() }
        end,
        function(g, s)
            g.icon:SetTexture(GetSpellIcon(s.spellID))
            g.label:SetText(GetSpellName(s.spellID))
        end)
    editorSpellRows[i] = row
    return row
end

function Editor_RefreshSpells()
    if not editor then return end
    local query = CurrentSearch()
    local shown = 0

    local function PlaceRow(row)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", editor.spellScroll.child, "TOPLEFT", 0, -shown * SPELL_ROW_H)
        row:SetPoint("TOPRIGHT", editor.spellScroll.child, "TOPRIGHT", -8, -shown * SPELL_ROW_H)
        row.zebra:SetColorTexture(0, 0, 0, shown % 2 == 0 and 0.1 or 0.2)
        row:Show()
        shown = shown + 1
    end

    -- Aggiunta diretta per spellID numerico (es. dal tooltip in game)
    local numericID = query:match("^%s*(%d+)%s*$")
    if numericID then
        local sid = tonumber(numericID)
        local row = AcquireSpellRow(shown + 1)
        row.spellID = sid
        row.avail = true
        row.icon:SetTexture(GetSpellIcon(sid))
        row.icon:SetDesaturated(false)
        row.label:SetText("|cff0cd29d" .. L.ADD_BY_ID:format(sid) .. "|r " .. GetSpellName(sid))
        row.label:SetTextColor(1, 1, 1, 0.75)
        PlaceRow(row)
    end

    for _, s in ipairs(knownSpells) do
        if query == "" or (s.name and s.name:lower():find(query, 1, true)) then
            local row = AcquireSpellRow(shown + 1)
            row.spellID = s.spellID
            row.avail = s.avail ~= false
            row.icon:SetTexture(s.icon or GetSpellIcon(s.spellID))
            row.label:SetText(s.name or ("Spell " .. s.spellID))
            if row.avail then
                row.icon:SetDesaturated(false)
                row.label:SetTextColor(1, 1, 1, 0.75)
            else
                row.icon:SetDesaturated(true)
                row.label:SetTextColor(1, 0.4, 0.4, 0.9)
            end
            PlaceRow(row)
        end
    end
    for i = shown + 1, #editorSpellRows do editorSpellRows[i]:Hide() end
    editor.spellScroll.child:SetHeight(math.max(shown * SPELL_ROW_H, 1))
    editor.spellScroll.UpdateThumb()
end

-- ---------------------------------------------------------------------------
-- Colonna sequenza: righe con grip, drag per riordinare, click = x1/x2/x3
-- ---------------------------------------------------------------------------

local function AcquireStepRow(i)
    local row = editorStepRows[i]
    if row then return row end
    row = CreateFrame("Button", nil, editor.stepScroll.child)
    row:SetHeight(STEP_ROW_H)

    row.zebra = ETex(row, "BACKGROUND", 0, 0, 0, 0.1)
    row.zebra:SetAllPoints()
    row.grip = EFont(row, 12, 0.30)
    row.grip:SetPoint("LEFT", 6, 0)
    row.grip:SetText("::")
    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetSize(20, 20)
    row.icon:SetPoint("LEFT", 20, 0)
    row.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    row.label = EFont(row, 12, 0.85)
    row.label:SetPoint("LEFT", row.icon, "RIGHT", 7, 0)
    row.label:SetJustifyH("LEFT")
    row.label:SetWordWrap(false)
    row.hover = ETex(row, "ARTWORK", 1, 1, 1, 0)
    row.hover:SetAllPoints()

    row.del = CreateFrame("Button", nil, row)
    row.del:SetSize(18, 18)
    row.del:SetPoint("RIGHT", -4, 0)
    row.del.label = EFont(row.del, 12, 0.35)
    row.del.label:SetPoint("CENTER")
    row.del.label:SetText("X")
    row.del:SetScript("OnEnter", function(s) s.label:SetTextColor(1, 0.35, 0.35, 1) end)
    row.del:SetScript("OnLeave", function(s) s.label:SetTextColor(1, 1, 1, 0.35) end)
    row.del:SetScript("OnClick", function(s)
        local opener = GetActiveOpener()
        local idx = s:GetParent().index
        if opener and opener.steps[idx] then
            table.remove(opener.steps, idx)
            ResetRun()
            Tracker_Refresh()
            Editor_RefreshSteps()
        end
    end)
    row.label:SetPoint("RIGHT", row.del, "LEFT", -4, 0)

    row:SetScript("OnEnter", function(s)
        s.hover:SetColorTexture(1, 1, 1, 0.04)
        s.grip:SetTextColor(1, 1, 1, 0.6)
        local opener = GetActiveOpener()
        local step = opener and opener.steps[s.index]
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        if step and step.kind ~= "info" and step.spellID then
            pcall(GameTooltip.SetSpellByID, GameTooltip, step.spellID)
            GameTooltip:AddLine(L.CLICK_CYCLE, 0.6, 0.9, 1)
        else
            GameTooltip:SetText(L.INFO_STEP_TT)
        end
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function(s)
        s.hover:SetColorTexture(1, 1, 1, 0)
        s.grip:SetTextColor(1, 1, 1, 0.30)
        GameTooltip:Hide()
    end)
    row:SetScript("OnClick", function(s)
        if dragState then return end
        local opener = GetActiveOpener()
        local step = opener and opener.steps[s.index]
        if step and step.kind ~= "info" then
            step.count = ((step.count or 1) % 3) + 1
            ResetRun()
            Tracker_Refresh()
            Editor_RefreshSteps()
        end
    end)
    WireDrag(row,
        function(s)
            local opener = GetActiveOpener()
            if opener and opener.steps[s.index] then
                return { kind = "move", fromIndex = s.index, opener = opener }
            end
        end,
        function(g, s)
            local opener = GetActiveOpener()
            local step = opener and opener.steps[s.index]
            if not step then return end
            if step.kind == "info" then
                g.icon:SetTexture(step.icon or ICON_INFO)
                g.label:SetText(step.label or "Info")
            else
                g.icon:SetTexture(GetSpellIcon(step.spellID))
                g.label:SetText(GetSpellName(step.spellID))
            end
        end)
    editorStepRows[i] = row
    return row
end

function Editor_RefreshSteps()
    if not editor then return end
    local opener = GetActiveOpener()
    local steps = opener and opener.steps or {}
    for i, step in ipairs(steps) do
        local row = AcquireStepRow(i)
        row.index = i
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", editor.stepScroll.child, "TOPLEFT", 0, -(i - 1) * STEP_ROW_H)
        row:SetPoint("TOPRIGHT", editor.stepScroll.child, "TOPRIGHT", -8, -(i - 1) * STEP_ROW_H)
        row:Show()
        row.zebra:SetColorTexture(0, 0, 0, i % 2 == 1 and 0.1 or 0.2)
        if step.kind == "info" then
            row.icon:SetTexture(step.icon or ICON_INFO)
            row.label:SetText("|cff55dd55[i]|r " .. (step.label or "Info"))
        else
            row.icon:SetTexture(GetSpellIcon(step.spellID))
            local txt = i .. ". " .. GetSpellName(step.spellID)
            if (step.count or 1) > 1 then
                txt = txt .. " |cffffee55x" .. step.count .. "|r"
            end
            row.label:SetText(txt)
        end
    end
    for i = #steps + 1, #editorStepRows do editorStepRows[i]:Hide() end
    editor.stepScroll.child:SetHeight(math.max(#steps * STEP_ROW_H, 1))
    editor.stepScroll.UpdateThumb()
end

function Editor_RefreshAll()
    Editor_RefreshHeader()
    Editor_RefreshSteps()
    Editor_RefreshSpells()
end

-- ---------------------------------------------------------------------------
-- Costruzione finestra
-- ---------------------------------------------------------------------------

local function BuildEditor()
    editor = CreateFrame("Frame", "OpenerTrainerEditor", UIParent)
    editor:SetSize(EDITOR_W, EDITOR_H)
    editor:SetPoint("CENTER")
    editor:SetFrameStrata("DIALOG")
    editor:SetMovable(true)
    editor:EnableMouse(true)
    editor:SetClampedToScreen(true)
    editor:RegisterForDrag("LeftButton")
    editor:SetScript("OnDragStart", editor.StartMoving)
    editor:SetScript("OnDragStop", editor.StopMovingOrSizing)
    editor:Hide()

    ETex(editor, "BACKGROUND", PANEL_BG[1], PANEL_BG[2], PANEL_BG[3], 0.97):SetAllPoints(editor)
    EBorder(editor, 1, 1, 1, 0.15)

    -- Header: titolo con accent + underline stile tab, X flat
    local header = CreateFrame("Frame", nil, editor)
    header:SetPoint("TOPLEFT")
    header:SetPoint("TOPRIGHT")
    header:SetHeight(ED_HEADER_H)
    local headerLine = ETex(header, "OVERLAY", 1, 1, 1, 0.06)
    headerLine:SetPoint("BOTTOMLEFT")
    headerLine:SetPoint("BOTTOMRIGHT")
    headerLine:SetHeight(1)

    editor.title = EFont(header, 16, 1)
    editor.title:SetPoint("LEFT", 14, 0)
    editor.title:SetText("|cff0cd29dOpener|rTrainer")
    local underline = ETex(header, "OVERLAY", ACCENT.r, ACCENT.g, ACCENT.b, 1)
    underline:SetPoint("TOPLEFT", editor.title, "BOTTOMLEFT", 0, -5)
    underline:SetSize(44, 2)

    local closeBtn = CreateFrame("Button", nil, header)
    closeBtn:SetSize(26, 26)
    closeBtn:SetPoint("RIGHT", -8, 0)
    closeBtn.label = EFont(closeBtn, 14, 0.55)
    closeBtn.label:SetPoint("CENTER")
    closeBtn.label:SetText("X")
    closeBtn:SetScript("OnEnter", function(s) s.label:SetTextColor(1, 0.35, 0.35, 1) end)
    closeBtn:SetScript("OnLeave", function(s) s.label:SetTextColor(1, 1, 1, 0.55) end)
    closeBtn:SetScript("OnClick", function() editor:Hide() end)

    -- Sidebar opener
    local sidebar = CreateFrame("Frame", nil, editor)
    sidebar:SetPoint("TOPLEFT", 0, -ED_HEADER_H)
    sidebar:SetPoint("BOTTOMLEFT", 0, ED_FOOTER_H)
    sidebar:SetWidth(ED_SIDEBAR_W)
    local sideDiv = ETex(sidebar, "OVERLAY", 1, 1, 1, 0.06)
    sideDiv:SetPoint("TOPRIGHT")
    sideDiv:SetPoint("BOTTOMRIGHT")
    sideDiv:SetWidth(1)
    local sideLabel = EFont(sidebar, 11, 0.41)
    sideLabel:SetPoint("TOPLEFT", 12, -10)
    sideLabel:SetText(L.SIDEBAR_OPENERS)

    editor.sideScroll = EScrollList(sidebar)
    editor.sideScroll:SetPoint("TOPLEFT", 0, -28)
    editor.sideScroll:SetPoint("BOTTOMRIGHT", -1, 36)
    editor.sideScroll.child:SetWidth(ED_SIDEBAR_W - 1)

    local newBtn = EButton(sidebar, ED_SIDEBAR_W - 20, 24, "+ " .. L.NEW, 12, function()
        local _, spec = GetOpeners()
        ShowDialog({
            text = L.POPUP_NEW,
            hasEdit = true,
            acceptFn = function(name)
                if not name or name == "" then name = "Opener" end
                db.openers[spec] = db.openers[spec] or {}
                local list = db.openers[spec]
                list[#list + 1] = { name = name, steps = {} }
                db.active[spec] = #list
                ResetRun(); Tracker_Refresh(); Editor_RefreshAll()
            end,
        })
    end)
    newBtn:SetPoint("BOTTOM", 0, 7)

    -- Colonna spell
    local spellsCol = CreateFrame("Frame", nil, editor)
    spellsCol:SetPoint("TOPLEFT", ED_SIDEBAR_W, -ED_HEADER_H)
    spellsCol:SetPoint("BOTTOMLEFT", ED_SIDEBAR_W, ED_FOOTER_H)
    spellsCol:SetWidth(290)
    local spellsDiv = ETex(spellsCol, "OVERLAY", 1, 1, 1, 0.06)
    spellsDiv:SetPoint("TOPRIGHT")
    spellsDiv:SetPoint("BOTTOMRIGHT")
    spellsDiv:SetWidth(1)
    local spellsLabel = EFont(spellsCol, 11, 0.41)
    spellsLabel:SetPoint("TOPLEFT", 12, -10)
    spellsLabel:SetText(L.SPELLS_COL)

    -- Search box custom (pattern Ellesmere: bg nero 0.4, placeholder grigio)
    editor.search = CreateFrame("EditBox", nil, spellsCol)
    editor.search:SetSize(266, 24)
    editor.search:SetPoint("TOPLEFT", 12, -26)
    editor.search:SetFont(EDITOR_FONT, 11, "")
    editor.search:SetTextColor(1, 1, 1, 0.9)
    editor.search:SetJustifyH("LEFT")
    editor.search:SetAutoFocus(false)
    editor.search:SetMaxLetters(40)
    editor.search:SetTextInsets(6, 6, 0, 0)
    ETex(editor.search, "BACKGROUND", 0, 0, 0, 0.4):SetAllPoints(editor.search)
    EBorder(editor.search, 1, 1, 1, 0.10)
    editor.searchPh = EFont(editor.search, 11, 0.4)
    editor.searchPh:SetPoint("LEFT", 6, 0)
    editor.searchPh:SetText(L.SEARCH_PH)
    editor.search:SetScript("OnTextChanged", function(self)
        editor.searchPh:SetShown((self:GetText() or "") == "")
        Editor_RefreshSpells()
    end)
    editor.search:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

    editor.spellScroll = EScrollList(spellsCol)
    editor.spellScroll:SetPoint("TOPLEFT", 0, -58)
    editor.spellScroll:SetPoint("BOTTOMRIGHT", -1, 4)
    editor.spellScroll.child:SetWidth(289)

    -- Colonna sequenza
    local stepsCol = CreateFrame("Frame", nil, editor)
    stepsCol:SetPoint("TOPLEFT", ED_SIDEBAR_W + 290, -ED_HEADER_H)
    stepsCol:SetPoint("BOTTOMRIGHT", 0, ED_FOOTER_H)
    local stepsLabel = EFont(stepsCol, 11, 0.41)
    stepsLabel:SetPoint("TOPLEFT", 12, -10)
    stepsLabel:SetText(L.STEPS_COL)

    editor.stepScroll = EScrollList(stepsCol)
    editor.stepScroll:SetPoint("TOPLEFT", 0, -28)
    editor.stepScroll:SetPoint("BOTTOMRIGHT", 0, 4)
    editor.stepScroll.child:SetWidth(EDITOR_W - ED_SIDEBAR_W - 290)

    -- La linea vive in un frame a livello alto: le righe (Button figli del
    -- child) altrimenti la coprirebbero
    local insHost = CreateFrame("Frame", nil, editor.stepScroll.child)
    insHost:SetAllPoints(editor.stepScroll.child)
    insHost:SetFrameLevel(editor.stepScroll.child:GetFrameLevel() + 10)
    insLine = ETex(insHost, "OVERLAY", ACCENT.r, ACCENT.g, ACCENT.b, 0.9)
    insLine:SetHeight(2)
    insLine:Hide()

    -- Footer: azioni + toggle auto-reset animato (pattern Ellesmere 40x20)
    local footer = CreateFrame("Frame", nil, editor)
    footer:SetPoint("BOTTOMLEFT")
    footer:SetPoint("BOTTOMRIGHT")
    footer:SetHeight(ED_FOOTER_H)
    local footerLine = ETex(footer, "OVERLAY", 1, 1, 1, 0.06)
    footerLine:SetPoint("TOPLEFT")
    footerLine:SetPoint("TOPRIGHT")
    footerLine:SetHeight(1)

    local fx = 10
    local function FooterBtn(text, fn)
        local b = EButton(footer, 72, 24, text, 12, fn)
        b:SetPoint("LEFT", fx, 0)
        fx = fx + 76
        return b
    end
    -- Il bersaglio (spec/idx/ref) viene catturato al click e riverificato
    -- all'accept: i dialog non sono modali e l'opener attiva può cambiare
    local function StillValid(spec, idx, ref)
        return db.openers[spec] and db.openers[spec][idx] == ref
    end
    FooterBtn(L.RENAME, function()
        local opener, idx, _, spec = GetActiveOpener()
        if not opener then Print(L.CREATE_FIRST) return end
        ShowDialog({
            text = L.POPUP_RENAME:format(opener.name),
            hasEdit = true, editText = opener.name, selectAll = true,
            acceptFn = function(name)
                if not name or name == "" then return end
                if StillValid(spec, idx, opener) then
                    opener.name = name
                    Tracker_Refresh(); Editor_RefreshAll()
                else
                    Print(L.CHANGED_ABORT_RENAME)
                end
            end,
        })
    end)
    FooterBtn(L.DELETE, function()
        local opener, idx, _, spec = GetActiveOpener()
        if not opener then return end
        ShowDialog({
            text = L.POPUP_DELETE:format(opener.name),
            acceptText = YES, cancelText = NO,
            acceptFn = function()
                if not StillValid(spec, idx, opener) then
                    Print(L.CHANGED_ABORT_DELETE)
                    return
                end
                local list = db.openers[spec]
                table.remove(list, idx)
                local act = db.active[spec]
                if act == idx then
                    db.active[spec] = list[1] and 1 or nil
                elseif act and act > idx then
                    db.active[spec] = act - 1
                end
                ResetRun(); Tracker_Refresh(); Editor_RefreshAll()
            end,
        })
    end)
    FooterBtn(L.ADD_INFO, function()
        local opener, idx, _, spec = GetActiveOpener()
        if not opener then Print(L.CREATE_FIRST) return end
        ShowDialog({
            text = L.POPUP_INFO,
            hasEdit = true, editText = "Pot + Items", selectAll = true,
            acceptFn = function(label)
                if not label or label == "" then label = "Info" end
                if StillValid(spec, idx, opener) then
                    opener.steps[#opener.steps + 1] = { kind = "info", label = label }
                    ResetRun(); Tracker_Refresh(); Editor_RefreshAll()
                else
                    Print(L.CHANGED_ABORT_STEP)
                end
            end,
        })
    end)
    fx = fx + 10
    FooterBtn(L.EXPORT, function()
        local opener = GetActiveOpener()
        if not opener then Print(L.CREATE_FIRST) return end
        ShowDialog({
            text = L.POPUP_EXPORT:format(opener.name),
            hasEdit = true, editText = ExportOpener(opener), selectAll = true,
            noCancel = true,
        })
    end)
    FooterBtn(L.IMPORT, function()
        local _, spec = GetOpeners()
        ShowDialog({
            text = L.POPUP_IMPORT,
            hasEdit = true,
            acceptFn = function(text)
                DoImportString(text, spec)
            end,
        })
    end)
    local presetsBtn
    presetsBtn = FooterBtn(L.PRESETS, function()
        TogglePresetMenu(presetsBtn)
    end)
    FooterBtn(L.TALENTS, function()
        local opener, idx, _, spec = GetActiveOpener()
        if not opener then Print(L.CREATE_FIRST) return end
        local function SaveTalents(text)
            local t = (text or ""):gsub("%s+", "")
            if t == "" then
                if StillValid(spec, idx, opener) then
                    opener.talents = nil
                    Print(L.TALENTS_REMOVED)
                end
                return nil
            elseif t:find("[^%w+/=]") then
                Print(L.TALENTS_INVALID)
                return nil
            end
            if StillValid(spec, idx, opener) then
                opener.talents = t
                Print(L.TALENTS_SAVED)
            end
            return t
        end
        ShowDialog({
            text = L.POPUP_TALENTS:format(opener.name),
            hasEdit = true, editText = opener.talents or "", selectAll = true,
            acceptFn = SaveTalents,
            altText = L.APPLY,
            altFn = function(text)
                local t = SaveTalents(text)
                if t then ApplyTalentString(t, opener.name) end
            end,
        })
    end)

    -- Toggle animato (40x20, track #444 -> accent, knob bianco)
    local TG_W, TG_H, TG_PAD, TG_DUR = 40, 20, 2, 0.075
    local toggle = CreateFrame("Button", nil, footer)
    toggle:SetSize(TG_W, TG_H)
    toggle:SetPoint("RIGHT", -12, 0)
    local tgBg = ETex(toggle, "BACKGROUND", 0.267, 0.267, 0.267, 0.65)
    tgBg:SetAllPoints()
    local knob = ETex(toggle, "ARTWORK", 1, 1, 1, 0.5)
    local knobSz = TG_H - TG_PAD * 2
    local function Lerp(a, b, t) return a + (b - a) * t end
    local animProgress = 0
    local function ApplyToggleVisual(p)
        local x = Lerp(TG_PAD, TG_W - TG_PAD - knobSz, p)
        knob:ClearAllPoints()
        knob:SetPoint("TOPLEFT", toggle, "TOPLEFT", x, -TG_PAD)
        knob:SetSize(knobSz, knobSz)
        tgBg:SetColorTexture(Lerp(0.267, ACCENT.r, p), Lerp(0.267, ACCENT.g, p),
            Lerp(0.267, ACCENT.b, p), Lerp(0.65, 0.75, p))
        knob:SetColorTexture(1, 1, 1, Lerp(0.5, 1, p))
    end
    editor.SyncAutoToggle = function()
        animProgress = db.autoReset and 1 or 0
        ApplyToggleVisual(animProgress)
    end
    toggle:SetScript("OnClick", function()
        db.autoReset = not db.autoReset
        local target = db.autoReset and 1 or 0
        toggle:SetScript("OnUpdate", function(s, elapsed)
            local dir = (target == 1) and 1 or -1
            animProgress = animProgress + dir * (elapsed / TG_DUR)
            if (dir == 1 and animProgress >= 1) or (dir == -1 and animProgress <= 0) then
                animProgress = target
                s:SetScript("OnUpdate", nil)
            end
            ApplyToggleVisual(animProgress)
        end)
    end)
    local tgLabel = EFont(footer, 11, 0.53)
    tgLabel:SetPoint("RIGHT", toggle, "LEFT", -8, 0)
    tgLabel:SetText(L.AUTORESET_LABEL)

    editor:SetScript("OnShow", function()
        HideOpenerMenu()
        if presetMenu then presetMenu:Hide() end
        editor.SyncAutoToggle()
        knownSpells = BuildPickerPool()
        Editor_RefreshAll()
    end)
    editor:SetScript("OnHide", function()
        if presetMenu then presetMenu:Hide() end
    end)
end

local function ToggleEditor()
    if not editor then return end
    if editor:IsShown() then editor:Hide() else editor:Show() end
end

-- ---------------------------------------------------------------------------
-- Export/Import: stringa SOLO alfanumerica.
-- Formato: marker maiuscolo + payload [0-9a-z].
--   V1  versione | N<hex> nome | S<id> step spell | C<n> count | L<hex> label
--   I<hex> step info
-- I payload testuali sono hex (byte UTF-8), quindi nessun carattere speciale
-- può finire nella stringa. All'import le spell inesistenti vengono saltate.
-- ---------------------------------------------------------------------------

local function HexEncode(s)
    return (s:gsub(".", function(c) return string.format("%02x", c:byte()) end))
end

local function HexDecode(s)
    if not s or #s % 2 ~= 0 or s:find("[^0-9a-f]") then return nil end
    return (s:gsub("%x%x", function(cc) return string.char(tonumber(cc, 16)) end))
end

function ExportOpener(opener)
    local parts = { "V1", "N" .. HexEncode(opener.name or "Opener") }
    if opener.talents and opener.talents ~= "" then
        parts[#parts + 1] = "T" .. HexEncode(opener.talents)
    end
    for _, step in ipairs(opener.steps) do
        if step.kind == "info" then
            parts[#parts + 1] = "I" .. HexEncode(step.label or "Info")
        elseif step.spellID then
            parts[#parts + 1] = "S" .. tostring(step.spellID)
            if (step.count or 1) > 1 then
                parts[#parts + 1] = "C" .. tostring(step.count)
            end
            if step.label then
                parts[#parts + 1] = "L" .. HexEncode(step.label)
            end
        end
    end
    return table.concat(parts)
end

local function SpellExists(id)
    if not (C_Spell and C_Spell.GetSpellInfo) then return true end
    local ok, info = pcall(C_Spell.GetSpellInfo, id)
    return ok and type(info) == "table" and info.name ~= nil
end

-- Ritorna (opener, skipped) oppure nil se la stringa non è valida.
function ImportOpener(str)
    str = (str or ""):gsub("%s+", "")
    if str == "" or str:find("[^%w]") then return nil end
    local version, name, talents = nil, nil, nil
    local steps, skipped = {}, 0
    local cur = nil
    local function flush()
        if cur then steps[#steps + 1] = cur; cur = nil end
    end
    for marker, payload in str:gmatch("(%u)([%da-z]*)") do
        if marker == "V" then
            version = payload
        elseif marker == "N" then
            name = HexDecode(payload)
        elseif marker == "T" then
            local t = HexDecode(payload)
            if t and t ~= "" then talents = t end
        elseif marker == "S" then
            flush()
            local id = tonumber(payload)
            if id and SpellExists(id) then
                cur = { kind = "spell", spellID = id, count = 1 }
            else
                skipped = skipped + 1
            end
        elseif marker == "C" then
            if cur then cur.count = math.max(1, math.min(9, tonumber(payload) or 1)) end
        elseif marker == "L" then
            if cur then cur.label = HexDecode(payload) end
        elseif marker == "I" then
            flush()
            steps[#steps + 1] = { kind = "info", label = HexDecode(payload) or "Info" }
        end
        -- marker sconosciuti: ignorati (tolleranza a versioni future)
    end
    flush()
    if version ~= "1" or #steps == 0 then return nil end
    return {
        name = (name and name ~= "" and name) or "Imported",
        steps = steps,
        talents = talents,
    }, skipped
end

-- ---------------------------------------------------------------------------
-- Attivazione loadout talenti: importa la stringa tra i loadout salvati
-- (col nome dell'opener) e la carica. Best-effort: ogni chiamata è pcall-ata
-- e in caso di API assente/di rifiuto si stampa un messaggio, mai un errore.
-- ---------------------------------------------------------------------------

local function EnsureTalentUILoaded()
    if C_AddOns and C_AddOns.LoadAddOn then
        pcall(C_AddOns.LoadAddOn, "Blizzard_PlayerSpells")
        pcall(C_AddOns.LoadAddOn, "Blizzard_ClassTalentUI")
    elseif type(LoadAddOn) == "function" then
        pcall(LoadAddOn, "Blizzard_PlayerSpells")
        pcall(LoadAddOn, "Blizzard_ClassTalentUI")
    end
end

-- Midnight ha cambiato firma: ImportLoadout(configID, entries, name [, importString]).
-- Strada 1: pipeline ufficiale Blizzard (ClassTalentImportExportMixin), la stessa
-- del pannello talenti: fa parsing, validazione spec/versione e chiama l'API giusta.
-- Strada 2 (fallback): firma nuova diretta passando importString come 4° argomento.
-- SOLO la pipeline ufficiale del pannello talenti: parsa la stringa in entries
-- reali e chiama ImportLoadout(configID, entries, name). MAI chiamare l'API con
-- entries vuote: crea (e attiva) un loadout azzerato — verificato in game.
local function ImportTalentLoadout(str, name)
    EnsureTalentUILoaded()
    local mixin = ClassTalentImportExportMixin
    if not (mixin and mixin.ImportLoadout and type(CreateFromMixins) == "function") then
        return false, "unsupported"
    end
    local lastErr
    local host = CreateFromMixins(mixin)
    -- Metodi che il mixin potrebbe chiamare ma che vivono sul frame dei talenti:
    -- catch-all no-op, così un helper mancante non fa esplodere la pipeline
    setmetatable(host, { __index = function() return function() end end })
    host.ShowImportError = function(_, err) lastErr = tostring(err) end
    -- Dal sorgente Blizzard: ImportLoadout usa self:GetConfigID() e
    -- self:GetTreeInfo(), metodi del frame talenti — implementazioni reali:
    host.GetConfigID = function()
        return C_ClassTalents.GetActiveConfigID()
    end
    host.GetTreeInfo = function()
        local configID = C_ClassTalents.GetActiveConfigID()
        local configInfo = configID and C_Traits.GetConfigInfo(configID)
        local treeID = configInfo and configInfo.treeIDs and configInfo.treeIDs[1]
        return treeID and C_Traits.GetTreeInfo(configID, treeID) or nil
    end
    local ok, success, importErr = pcall(host.ImportLoadout, host, str, name)
    if ok and success then return true end
    return false, "mixin: " .. tostring((not ok and success) or importErr or lastErr or "refused")
end

function ApplyTalentString(str, name)
    str = (str or ""):gsub("%s+", "")
    if str == "" then Print(L.TALENTS_EMPTY) return end
    if str:find("[^%w+/=]") then Print(L.TALENTS_INVALID) return end
    if InCombatLockdown and InCombatLockdown() then Print(L.TALENTS_COMBAT) return end
    if not (C_ClassTalents and C_ClassTalents.ImportLoadout) then
        Print(L.TALENTS_UNSUPPORTED)
        return
    end
    name = (name or "Opener"):sub(1, 24)
    local okImp, err = ImportTalentLoadout(str, name)
    if not okImp then
        Print(L.TALENTS_APPLY_FAIL:format(err or "?"))
        return
    end
    Print(L.TALENTS_IMPORTED:format(name))
    -- L'attivazione richiede il configID appena creato: cercalo per nome
    C_Timer.After(0.5, function()
        local okLoad = pcall(function()
            local specID = GetCurrentSpecID()
            local ids = C_ClassTalents.GetConfigIDsBySpecID
                and C_ClassTalents.GetConfigIDsBySpecID(specID)
            for _, id in ipairs(ids or {}) do
                local info = C_Traits.GetConfigInfo(id)
                if info and info.name == name then
                    C_ClassTalents.LoadConfig(id, true)
                    if C_ClassTalents.UpdateLastSelectedSavedConfigID then
                        pcall(C_ClassTalents.UpdateLastSelectedSavedConfigID, specID, id)
                    end
                    Print(L.TALENTS_APPLIED:format(name))
                    return
                end
            end
            error("config not found")
        end)
        if not okLoad then Print(L.TALENTS_APPLY_FAIL:format("load")) end
    end)
end

-- ---------------------------------------------------------------------------
-- Pulsante minimappa (hand-rolled, niente librerie)
-- ---------------------------------------------------------------------------

local mmBtn

local function Rad(deg) return deg * math.pi / 180 end

-- atan2 in gradi, con fallback corretto per Lua 5.1 (math.atan a un argomento)
local function Atan2Deg(y, x)
    if math.atan2 then return math.deg(math.atan2(y, x)) end
    if x == 0 then return y >= 0 and 90 or -90 end
    local a = math.deg(math.atan(y / x))
    if x < 0 then a = a + (y >= 0 and 180 or -180) end
    return a
end

local function PositionMinimapButton()
    local angle = Rad(db.minimap.angle or 215)
    local r = (Minimap:GetWidth() / 2) + 5
    mmBtn:ClearAllPoints()
    mmBtn:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * r, math.sin(angle) * r)
end

local function BuildMinimapButton()
    mmBtn = CreateFrame("Button", "OpenerTrainerMinimapButton", Minimap)
    mmBtn:SetSize(31, 31)
    mmBtn:SetFrameStrata("MEDIUM")
    mmBtn:SetFrameLevel(8)
    mmBtn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    mmBtn:RegisterForDrag("LeftButton")
    mmBtn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local icon = mmBtn:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("TOPLEFT", 6, -6)
    icon:SetTexture(ICON_PATH)

    local border = mmBtn:CreateTexture(nil, "OVERLAY")
    border:SetSize(53, 53)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    mmBtn:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local scale = Minimap:GetEffectiveScale()
            local cx, cy = GetCursorPosition()
            cx, cy = cx / scale, cy / scale
            local dx, dy = cx - mx, cy - my
            db.minimap.angle = Atan2Deg(dy, dx)
            PositionMinimapButton()
        end)
    end)
    mmBtn:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)
    mmBtn:SetScript("OnClick", function(_, button)
        if button == "RightButton" then
            ToggleEditor()
        elseif IsShiftKeyDown() then
            if bar:IsShown() then
                bar:Hide(); db.barHidden = true
            else
                bar:Show(); db.barHidden = false
            end
        else
            -- Toggle complessivo: se qualcosa è nascosto riporta tutto visibile,
            -- altrimenti nasconde tutto.
            local anyHidden = (not tracker:IsShown()) or (not bar:IsShown())
            if anyHidden then
                tracker:Show(); db.hidden = false
                bar:Show(); db.barHidden = false
            else
                tracker:Hide(); db.hidden = true
                bar:Hide(); db.barHidden = true
            end
        end
    end)
    mmBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("OpenerTrainer")
        GameTooltip:AddLine(L.MM_LEFT, 1, 1, 1)
        GameTooltip:AddLine(L.MM_SHIFT, 1, 1, 1)
        GameTooltip:AddLine(L.MM_RIGHT, 1, 1, 1)
        GameTooltip:AddLine(L.MM_DRAG, 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    mmBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    PositionMinimapButton()
end

-- ---------------------------------------------------------------------------
-- Slash
-- ---------------------------------------------------------------------------

SLASH_OPENERTRAINER1 = "/opener"
SLASH_OPENERTRAINER2 = "/opt"
SlashCmdList.OPENERTRAINER = function(msg)
    if not (db and tracker) then
        Print(L.NOT_READY)
        return
    end
    msg = (msg or ""):gsub("^%s+", ""):gsub("%s+$", ""):lower()
    if msg == "reset" then
        ResetRun(); Tracker_Refresh()
        Print(L.RUN_RESET)
    elseif msg == "edit" or msg == "editor" then
        ToggleEditor()
    elseif msg == "show" then
        tracker:Show(); db.hidden = false
    elseif msg == "hide" then
        tracker:Hide(); db.hidden = true
    elseif msg == "bar" then
        if bar:IsShown() then
            bar:Hide(); db.barHidden = true
        else
            bar:Show(); db.barHidden = false
        end
    elseif msg == "autoreset" then
        db.autoReset = not db.autoReset
        if editor and editor.SyncAutoToggle then editor.SyncAutoToggle() end
        Print(db.autoReset and L.AUTORESET_ON or L.AUTORESET_OFF)
    elseif msg == "status" then
        local opener, idx, list, spec = GetActiveOpener()
        Print(L.STATUS:format(
            VERSION, tostring(spec),
            opener and opener.name or L.STATUS_NONE, idx or 0, #list, run.pointer))
    else
        if tracker:IsShown() then tracker:Hide(); db.hidden = true
        else tracker:Show(); db.hidden = false end
    end
end

-- ---------------------------------------------------------------------------
-- Eventi (handler PRIMA delle registrazioni; unit event deferiti — lezioni CCC)
-- ---------------------------------------------------------------------------

local lastPoolScan = 0

local ev = CreateFrame("Frame")
ev:SetScript("OnEvent", function(_, event, arg1, _, arg3)
    if event == "ADDON_LOADED" then
        if arg1 == ADDON_NAME then
            InitDB()
            ev:UnregisterEvent("ADDON_LOADED")
        end
    elseif event == "PLAYER_LOGIN" then
        -- pcall: un errore di build deve finire in chat, non uccidere il login
        local okBuild, errBuild = pcall(function()
            BuildTracker()
            BuildBar()
            BuildEditor()
            BuildMinimapButton()
        end)
        if not okBuild then
            Print("|cffff4040build error:|r " .. tostring(errBuild))
        end
        if tracker and tracker.editBtn then
            tracker.editBtn:SetScript("OnClick", ToggleEditor)
        end
        ResetRun()
        Tracker_Refresh()
        C_Timer.After(0, function()
            ev:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
            ev:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
            ev:RegisterEvent("PLAYER_REGEN_ENABLED")
            -- cambi talenti: ricalcolo del "conosciuta/non talentata"
            pcall(ev.RegisterEvent, ev, "SPELLS_CHANGED")
            pcall(ev.RegisterEvent, ev, "TRAIT_CONFIG_UPDATED")
            SeedDefaults()
            BuildTalentMap()
            Tracker_Refresh()
        end)
        Print(L.LOADED:format(VERSION))
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        OnPlayerCast(arg3)
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Uscita dal combat: reset automatico (disattivabile con /opener autoreset)
        if db.autoReset then
            ResetRun()
            Tracker_Refresh()
        end
    elseif event == "SPELLS_CHANGED" or event == "TRAIT_CONFIG_UPDATED" then
        BuildTalentMap()
        -- Accumula il pool anche a editor chiuso (throttle): è QUI che le
        -- forme Metamorphosis diventano visibili e catturabili
        if GetTime() - lastPoolScan > 10 then
            lastPoolScan = GetTime()
            EnumerateKnownSpells()
        end
        Tracker_Refresh()
        if editor and editor:IsShown() then
            knownSpells = BuildPickerPool()
            Editor_RefreshSpells()
        end
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        if arg1 and arg1 ~= "player" then return end
        SeedDefaults()
        BuildTalentMap()
        ResetRun()
        Tracker_Refresh()
        HideOpenerMenu()
        if editor and editor:IsShown() then
            knownSpells = BuildPickerPool()
            Editor_RefreshAll()
        end
    end
end)
ev:RegisterEvent("ADDON_LOADED")
ev:RegisterEvent("PLAYER_LOGIN")
