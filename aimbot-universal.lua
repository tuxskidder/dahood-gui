-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                          GHK'F SERR ZRAH                             ║
-- ║                    Havirefny Zbovyr & CP Pbzcngvoyr                   ║
-- ║                         Irefvba 3.0.1 - Svkrq                       ║
-- ║          Jbexf jvgu Krab, Qrygn, Syhkhf, Neprhf K & Zber            ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Havirefny rkrphgbe pbzcngvovyvgl purpx
ybpny rkrphgbe = vqragvslrkrphgbe naq vqragvslrkrphgbe() be "Haxabja"
jnea("🚀 Ybnqvat Ghk'f SERR Zrah ba: " .. rkrphgbe)

-- Fnsr freivpr ybnqvat jvgu snyyonpxf
ybpny shapgvba trgFreivpr(anzr)
    erghea tnzr:SvaqFreivpr(anzr) be tnzr:TrgFreivpr(anzr)
raq

-- Ybnq Enlsvryq HV jvgu zhygvcyr snyyonpxf
ybpny Enlsvryq
ybpny ybnqFhpprff = snyfr

-- Gel zhygvcyr HV yvoenel fbheprf
ybpny fbheprf = {
    'uggcf://fvevhf.zrah/enlsvryq',
    'uggcf://enj.tvguhohfrepbagrag.pbz/fuyrkjner/Enlsvryq/znva/fbhepr',
    'uggcf://enj.tvguhohfrepbagrag.pbz/fuyrkjner/Enlsvryq/znfgre/fbhepr'
}

sbe v, fbhepr va vcnvef(fbheprf) qb
    ybpny fhpprff, erfhyg = cpnyy(shapgvba()
        erghea ybnqfgevat(tnzr:UggcTrg(fbhepr))()
    raq)
    vs fhpprff naq erfhyg gura
        Enlsvryq = erfhyg
        ybnqFhpprff = gehr
        jnea("✅ HV ybnqrq sebz fbhepr " .. v)
        oernx
    raq
raq

vs abg ybnqFhpprff gura
    -- Snyyonpx abgvsvpngvba
    ybpny FgnegreThv = trgFreivpr("FgnegreThv")
    FgnegreThv:FrgPber("FraqAbgvsvpngvba", {
        Gvgyr = "Ghk'f SERR Zrah";
        Grkg = "Snvyrq gb ybnq HV! Purpx lbhe rkrphgbe.";
        Qhengvba = 10;
    })
    erghea
raq

-- Havirefny Freivprf (pbzcngvoyr jvgu nyy rkrphgbef)
ybpny Cynlref = trgFreivpr("Cynlref")
ybpny EhaFreivpr = trgFreivpr("EhaFreivpr")
ybpny HfreVachgFreivpr = trgFreivpr("HfreVachgFreivpr")
ybpny GjrraFreivpr = trgFreivpr("GjrraFreivpr")
ybpny Jbexfcnpr = trgFreivpr("Jbexfcnpr") be jbexfcnpr
ybpny FgnegreThv = trgFreivpr("FgnegreThv")
ybpny UggcFreivpr = trgFreivpr("UggcFreivpr")
ybpny GryrcbegFreivpr = trgFreivpr("GryrcbegFreivpr")
ybpny Yvtugvat = trgFreivpr("Yvtugvat")
ybpny ErcyvpngrqFgbentr = trgFreivpr("ErcyvpngrqFgbentr")
ybpny IveghnyVachgZnantre = trgFreivpr("IveghnyVachgZnantre")
ybpny ThvFreivpr = trgFreivpr("ThvFreivpr")
ybpny PbagrkgNpgvbaFreivpr = trgFreivpr("PbagrkgNpgvbaFreivpr")

-- Zbovyr qrgrpgvba
ybpny vfZbovyr = HfreVachgFreivpr.GbhpuRanoyrq naq abg HfreVachgFreivpr.XrlobneqRanoyrq

-- Inevnoyrf
ybpny YbpnyCynlre = Cynlref.YbpnyCynlre
ybpny Pnzren = Jbexfcnpr.PheeragPnzren be Jbexfcnpr:SvaqSvefgPuvyq("Pnzren")
ybpny Zbhfr = YbpnyCynlre:TrgZbhfr()

-- Pbaarpgvba znantrzrag
ybpny pbaarpgvbaf = {}
ybpny npgvirPbaarpgvbaf = 0

-- Zbirzrag inevnoyrf
ybpny sylFcrrq = 50
ybpny jnyxFcrrq = 16
ybpny whzcCbjre = 50
ybpny sylRanoyrq = snyfr
ybpny abpyvcRanoyrq = snyfr
ybpny fcrrqUnpxRanoyrq = snyfr
ybpny vasvavgrWhzcRanoyrq = snyfr
ybpny sylObqlIrybpvgl = avy
ybpny sylObqlNathyneIrybpvgl = avy

-- Ivfhny inevnoyrf
ybpny rfcRanoyrq = snyfr
ybpny rfcPbybe = Pbybe3.sebzETO(255, 0, 0)
ybpny shyyoevtugRanoyrq = snyfr
ybpny grnzPurpxRanoyrq = gehr
ybpny rfcBowrpgf = {}

-- Pbzong inevnoyrf
ybpny nvzobgRanoyrq = snyfr
ybpny nvzobgSBI = 100
ybpny xvyyNhenRanoyrq = snyfr
ybpny nhgbPyvpxreRanoyrq = snyfr
ybpny pyvpxFcrrq = 10
ybpny ynfgPyvpx = 0

-- Zvfp inevnoyrf
ybpny nagvNsxRanoyrq = snyfr
ybpny pungFcnzRanoyrq = snyfr
ybpny fcnzZrffntr = "Ghk'f SERR Zrah vf gur orfg!"
ybpny fcnzQrynl = 1

-- Cresbeznapr genpxvat
ybpny scfPbhagre = 0
ybpny ynfgScfHcqngr = gvpx()
ybpny fpevcgFgnegGvzr = gvpx()

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                    HAVIREFNY HGVYVGL SHAPGVBAF                        ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Fnsr punenpgre trggre jvgu ergevrf
ybpny shapgvba trgPunenpgre(cynlre, ergevrf)
    cynlre = cynlre be YbpnyCynlre
    ergevrf = ergevrf be 5
    
    sbe v = 1, ergevrf qb
        ybpny pune = cynlre.Punenpgre
        vs pune naq pune.Cnerag gura
            erghea pune
        raq
        vs v < ergevrf gura
            jnvg(0.1)
        raq
    raq
    erghea avy
raq

-- Fnsr uhznabvq trggre
ybpny shapgvba trgUhznabvq(cynlre)
    ybpny punenpgre = trgPunenpgre(cynlre)
    vs abg punenpgre gura erghea avy raq
    
    erghea punenpgre:SvaqSvefgPuvyqBsPynff("Uhznabvq") be 
           punenpgre:SvaqSvefgPuvyq("Uhznabvq")
raq

-- Fnsr ebbg cneg trggre jvgu zhygvcyr snyyonpxf
ybpny shapgvba trgEbbgCneg(cynlre)
    ybpny punenpgre = trgPunenpgre(cynlre)
    vs abg punenpgre gura erghea avy raq
    
    erghea punenpgre:SvaqSvefgPuvyq("UhznabvqEbbgCneg") be
           punenpgre:SvaqSvefgPuvyq("Gbefb") be
           punenpgre:SvaqSvefgPuvyq("HccreGbefb") be
           punenpgre:SvaqSvefgPuvyq("YbjreGbefb") be
           punenpgre:SvaqSvefgPuvyq("Ebbg")
raq

-- Raunaprq nyvir purpx
ybpny shapgvba vfNyvir(cynlre)
    cynlre = cynlre be YbpnyCynlre
    ybpny punenpgre = trgPunenpgre(cynlre, 1)
    vs abg punenpgre gura erghea snyfr raq
    
    ybpny uhznabvq = trgUhznabvq(cynlre)
    ybpny ebbgCneg = trgEbbgCneg(cynlre)
    
    erghea uhznabvq naq ebbgCneg naq 
           uhznabvq.Urnygu > 0 naq 
           uhznabvq.Cnerag naq 
           ebbgCneg.Cnerag
raq

-- Havirefny pybfrfg cynlre svaqre
ybpny shapgvba trgPybfrfgCynlre(znkQvfgnapr)
    ybpny pybfrfgCynlre = avy
    ybpny fubegrfgQvfgnapr = znkQvfgnapr be zngu.uhtr
    ybpny zlEbbgCneg = trgEbbgCneg()
    
    vs abg zlEbbgCneg gura erghea avy raq
    
    sbe _, cynlre va cnvef(Cynlref:TrgCynlref()) qb
        vs cynlre ~= YbpnyCynlre naq vfNyvir(cynlre) gura
            ybpny gurveEbbgCneg = trgEbbgCneg(cynlre)
            vs gurveEbbgCneg gura
                ybpny qvfgnapr = (zlEbbgCneg.Cbfvgvba - gurveEbbgCneg.Cbfvgvba).Zntavghqr
                vs qvfgnapr < fubegrfgQvfgnapr gura
                    vs abg grnzPurpxRanoyrq be abg cynlre.Grnz be cynlre.Grnz ~= YbpnyCynlre.Grnz gura
                        fubegrfgQvfgnapr = qvfgnapr
                        pybfrfgCynlre = cynlre
                    raq
                raq
            raq
        raq
    raq
    
    erghea pybfrfgCynlre, fubegrfgQvfgnapr
raq

-- Havirefny abgvsvpngvba flfgrz
ybpny shapgvba abgvsl(gvgyr, pbagrag, qhengvba, vzntr)
    qhengvba = qhengvba be 3
    vzntr = vzntr be 4483362458
    
    -- Gel Enlsvryq abgvsvpngvba
    cpnyy(shapgvba()
        vs Enlsvryq naq Enlsvryq.Abgvsl gura
            Enlsvryq:Abgvsl({
                Gvgyr = gvgyr,
                Pbagrag = pbagrag,
                Qhengvba = qhengvba,
                Vzntr = vzntr
            })
        raq
    raq)
    
    -- Snyyonpx gb FgnegreThv
    cpnyy(shapgvba()
        FgnegreThv:FrgPber("FraqAbgvsvpngvba", {
            Gvgyr = gvgyr,
            Grkg = pbagrag,
            Qhengvba = qhengvba
        })
    raq)
    
    -- Pbafbyr bhgchg sbe qrohttvat
    jnea("📢 " .. gvgyr .. ": " .. pbagrag)
raq

-- Havirefny pyvcobneq shapgvba
ybpny shapgvba frgPyvcobneq(grkg)
    ybpny pyvcobneqShapgvbaf = {
        shapgvba() frgpyvcobneq(grkg) raq,
        shapgvba() gbpyvcobneq(grkg) raq,
        shapgvba() jevgrsvyr("pyvcobneq.gkg", grkg) raq,
        shapgvba() 
            vs fla naq fla.frg_pyvcobneq gura
                fla.frg_pyvcobneq(grkg)
            raq
        raq,
        shapgvba()
            vs Pyvcobneq naq Pyvcobneq.frg gura
                Pyvcobneq.frg(grkg)
            raq
        raq
    }
    
    sbe _, shap va vcnvef(pyvcobneqShapgvbaf) qb
        ybpny fhpprff = cpnyy(shap)
        vs fhpprff gura
            abgvsl("📋 Pbcvrq", "Grkg pbcvrq gb pyvcobneq!", 2)
            erghea gehr
        raq
    raq
    
    abgvsl("❌ Reebe", "Pyvcobneq abg fhccbegrq ba guvf rkrphgbe", 3)
    erghea snyfr
raq

-- Pbaarpgvba pyrnahc
ybpny shapgvba pyrnahcPbaarpgvba(anzr)
    vs pbaarpgvbaf[anzr] gura
        cpnyy(shapgvba()
            pbaarpgvbaf[anzr]:Qvfpbaarpg()
        raq)
        pbaarpgvbaf[anzr] = avy
        npgvirPbaarpgvbaf = zngu.znk(0, npgvirPbaarpgvbaf - 1)
    raq
raq

ybpny shapgvba pyrnahcNyyPbaarpgvbaf()
    sbe anzr, pbaarpgvba va cnvef(pbaarpgvbaf) qb
        cpnyy(shapgvba()
            vs pbaarpgvba naq pbaarpgvba.Pbaarpgrq gura
                pbaarpgvba:Qvfpbaarpg()
            raq
        raq)
    raq
    pbaarpgvbaf = {}
    npgvirPbaarpgvbaf = 0
raq

-- Fnsr vachg qrgrpgvba sbe zbovyr/CP
ybpny shapgvba vfXrlQbja(xrl)
    vs vfZbovyr gura
        erghea snyfr -- Zbovyr qbrfa'g fhccbeg xrlobneq
    raq
    erghea HfreVachgFreivpr:VfXrlQbja(xrl)
raq

-- Havirefny zbhfr pyvpx
ybpny shapgvba cresbezPyvpx()
    ybpny pheeragGvzr = gvpx()
    vs pheeragGvzr - ynfgPyvpx < (1 / pyvpxFcrrq) gura
        erghea
    raq
    ynfgPyvpx = pheeragGvzr
    
    cpnyy(shapgvba()
        vs zbhfr1pyvpx gura
            zbhfr1pyvpx()
        ryfrvs Zbhfr.Ohggba1Pyvpx gura
            Zbhfr.Ohggba1Pyvpx:Sver()
        ryfrvs IveghnyVachgZnantre gura
            IveghnyVachgZnantre:FraqZbhfrOhggbaRirag(Zbhfr.K, Zbhfr.L, 0, gehr, tnzr, snyfr)
            jnvg()
            IveghnyVachgZnantre:FraqZbhfrOhggbaRirag(Zbhfr.K, Zbhfr.L, 0, snyfr, tnzr, snyfr)
        raq
    raq)
raq

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        HAVIREFNY JVAQBJ PERNGVBA                      ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

ybpny Jvaqbj = Enlsvryq:PerngrJvaqbj({
    Anzr = "Ghk'f SERR Zrah - Havirefny",
    YbnqvatGvgyr = "Ybnqvat Havirefny Zrah...",
    YbnqvatFhogvgyr = "Pbzcngvoyr jvgu " .. rkrphgbe .. " | Zbovyr & CP Ernql",
    PbasvthengvbaFnivat = {
        Ranoyrq = gehr,
        SbyqreAnzr = "GhkHavirefnyZrah",
        SvyrAnzr = "HavirefnyPbasvt"
    },
    Qvfpbeq = {
        Ranoyrq = gehr,
        Vaivgr = "4S7eZDgTur"
    },
    XrlFlfgrz = snyfr
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                           UBZR GNO                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

ybpny UbzrGno = Jvaqbj:PerngrGno("🏠 Ubzr", 4483362458)

UbzrGno:PerngrYnory("🎉 Ghk'f SERR Zrah - Havirefny Rqvgvba")
UbzrGno:PerngrYnory("📱 " .. (vfZbovyr naq "Zbovyr" be "CP") .. " Zbqr | Rkrphgbe: " .. rkrphgbe)
UbzrGno:PerngrYnory("👨‍💻 Perngrq ol Ghk Fxvqqre")

-- Tnzr vasb jvgu reebe unaqyvat
ybpny tnzrVasb = "Haxabja Tnzr"
ybpny tnzrVq = tnzr.CynprVq be 0

cpnyy(shapgvba()
    vs UggcFreivpr gura
        ybpny fhpprff, erfhyg = cpnyy(shapgvba()
            erghea UggcFreivpr:WFBAQrpbqr(tnzr:UggcTrg("uggcf://tnzrf.eboybk.pbz/i1/tnzrf/" .. tnzrVq))
        raq)
        vs fhpprff naq erfhyg naq erfhyg.anzr gura
            tnzrVasb = erfhyg.anzr
        raq
    raq
raq)

UbzrGno:PerngrYnory("🎮 Tnzr: " .. tnzrVasb)
UbzrGno:PerngrYnory("🆔 Cynpr VQ: " .. gbfgevat(tnzrVq))
UbzrGno:PerngrYnory("👥 Cynlref: " .. gbfgevat(#Cynlref:TrgCynlref()))

-- Cresbeznapr ynoryf
ybpny ScfYnory = UbzrGno:PerngrYnory("📊 SCF: Pnyphyngvat...")
ybpny ZrzbelYnory = UbzrGno:PerngrYnory("💾 Zrzbel: Pnyphyngvat...")
ybpny HcgvzrYnory = UbzrGno:PerngrYnory("⏱️ Hcgvzr: 0f")
ybpny PbaarpgvbafYnory = UbzrGno:PerngrYnory("🔗 Pbaarpgvbaf: 0")

-- Cresbeznapr zbavgbevat
fcnja(shapgvba()
    juvyr jnvg(1) qb
        cpnyy(shapgvba()
            scfPbhagre = scfPbhagre + 1
            vs gvpx() - ynfgScfHcqngr >= 1 gura
                ybpny scf = zngu.sybbe(scfPbhagre)
                ScfYnory:Frg("📊 SCF: " .. gbfgevat(scf))
                scfPbhagre = 0
                ynfgScfHcqngr = gvpx()
                
                -- Zrzbel (vs ninvynoyr)
                ybpny zrzbelGrkg = "💾 Zrzbel: A/N"
                vs tnzr:TrgFreivpr("Fgngf") gura
                    ybpny fhpprff, zrzbel = cpnyy(shapgvba()
                        erghea tnzr:TrgFreivpr("Fgngf"):TrgGbgnyZrzbelHfntrZo()
                    raq)
                    vs fhpprff naq zrzbel gura
                        zrzbelGrkg = "💾 Zrzbel: " .. gbfgevat(zngu.sybbe(zrzbel)) .. " ZO"
                    raq
                raq
                ZrzbelYnory:Frg(zrzbelGrkg)
                
                -- Hcgvzr
                ybpny hcgvzr = zngu.sybbe(gvpx() - fpevcgFgnegGvzr)
                ybpny zvahgrf = zngu.sybbe(hcgvzr / 60)
                ybpny frpbaqf = hcgvzr % 60
                HcgvzrYnory:Frg("⏱️ Hcgvzr: " .. zvahgrf .. "z " .. frpbaqf .. "f")
                
                -- Pbaarpgvbaf
                PbaarpgvbafYnory:Frg("🔗 Pbaarpgvbaf: " .. gbfgevat(npgvirPbaarpgvbaf))
            raq
        raq)
    raq
raq)

-- Dhvpx npgvbaf
UbzrGno:PerngrOhggba({
    Anzr = "🔄 Erwbva Freire",
    Pnyyonpx = shapgvba()
        abgvsl("🔄 Erwbvavat", "Erwbvavat freire...", 2)
        cpnyy(shapgvba()
            GryrcbegFreivpr:Gryrcbeg(tnzrVq)
        raq)
    raq
})

UbzrGno:PerngrOhggba({
    Anzr = "📋 Pbcl Wbva Fpevcg",
    Pnyyonpx = shapgvba()
        ybpny wbvaFpevcg = fgevat.sbezng(
            'tnzr:TrgFreivpr("GryrcbegFreivpr"):GryrcbegGbCynprVafgnapr(%q, "%f")',
            tnzrVq, tnzr.WboVq be "haxabja"
        )
        frgPyvcobneq(wbvaFpevcg)
    raq
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        ZBIRZRAG GNO                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

ybpny ZbirzragGno = Jvaqbj:PerngrGno("🚀 Zbirzrag", 4370318685)

-- Syvtug fcrrq fyvqre
ZbirzragGno:PerngrFyvqre({
    Anzr = "Syvtug Fcrrq",
    Enatr = {1, 200},
    Vaperzrag = 1,
    Fhssvk = " fghqf/f",
    PheeragInyhr = 50,
    Synt = "syvtug_fcrrq",
    Pnyyonpx = shapgvba(Inyhr)
        sylFcrrq = Inyhr
    raq
})

-- Raunaprq syl jvgu zbovyr fhccbeg
ZbirzragGno:PerngrGbttyr({
    Anzr = "🛸 Havirefny Syl",
    PheeragInyhr = snyfr,
    Synt = "syl_gbttyr",
    Pnyyonpx = shapgvba(Inyhr)
        sylRanoyrq = Inyhr
        pyrnahcPbaarpgvba("syl")
        
        ybpny punenpgre = trgPunenpgre()
        ybpny ebbgCneg = trgEbbgCneg()
        
        vs Inyhr gura
            vs abg ebbgCneg gura
                abgvsl("❌ Reebe", "Punenpgre abg sbhaq! Gel erfcnjavat.", 3)
                erghea
            raq
            
            -- Perngr obql zbiref
            sylObqlIrybpvgl = Vafgnapr.arj("ObqlIrybpvgl")
            sylObqlIrybpvgl.Irybpvgl = Irpgbe3.arj(0, 0, 0)
            sylObqlIrybpvgl.ZnkSbepr = Irpgbe3.arj(4000, 4000, 4000)
            sylObqlIrybpvgl.Cnerag = ebbgCneg
            
            sylObqlNathyneIrybpvgl = Vafgnapr.arj("ObqlNathyneIrybpvgl")
            sylObqlNathyneIrybpvgl.NathyneIrybpvgl = Irpgbe3.arj(0, 0, 0)
            sylObqlNathyneIrybpvgl.ZnkGbedhr = Irpgbe3.arj(4000, 4000, 4000)
            sylObqlNathyneIrybpvgl.Cnerag = ebbgCneg
            
            -- Syvtug pbageby ybbc
            pbaarpgvbaf["syl"] = EhaFreivpr.Urnegorng:Pbaarpg(shapgvba()
                vs abg sylRanoyrq be abg sylObqlIrybpvgl be abg sylObqlIrybpvgl.Cnerag gura
                    erghea
                raq
                
                ybpny zbirIrpgbe = Irpgbe3.arj(0, 0, 0)
                ybpny pnzren = Pnzren be Jbexfcnpr.PheeragPnzren
                
                vs abg vfZbovyr gura
                    -- CP Pbagebyf
                    vs vfXrlQbja(Rahz.XrlPbqr.J) gura
                        zbirIrpgbe = zbirIrpgbe + pnzren.PSenzr.YbbxIrpgbe
                    raq
                    vs vfXrlQbja(Rahz.XrlPbqr.F) gura
                        zbirIrpgbe = zbirIrpgbe - pnzren.PSenzr.YbbxIrpgbe
                    raq
                    vs vfXrlQbja(Rahz.XrlPbqr.N) gura
                        zbirIrpgbe = zbirIrpgbe - pnzren.PSenzr.EvtugIrpgbe
                    raq
                    vs vfXrlQbja(Rahz.XrlPbqr.Q) gura
                        zbirIrpgbe = zbirIrpgbe + pnzren.PSenzr.EvtugIrpgbe
                    raq
                    vs vfXrlQbja(Rahz.XrlPbqr.Fcnpr) gura
                        zbirIrpgbe = zbirIrpgbe + Irpgbe3.arj(0, 1, 0)
                    raq
                    vs vfXrlQbja(Rahz.XrlPbqr.YrsgFuvsg) gura
                        zbirIrpgbe = zbirIrpgbe - Irpgbe3.arj(0, 1, 0)
                    raq
                ryfr
                    -- Zbovyr nhgb-syl (sbyybjf pnzren qverpgvba)
                    zbirIrpgbe = pnzren.PSenzr.YbbxIrpgbe * 0.5
                raq
                
                sylObqlIrybpvgl.Irybpvgl = zbirIrpgbe * sylFcrrq
            raq)
            
            npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 1
            abgvsl("✅ Syl", "Havirefny syl ranoyrq! " .. (vfZbovyr naq "(Nhgb-cvybg zbqr)" be "(JNFQ pbagebyf)"), 3)
        ryfr
            -- Pyrnahc
            vs sylObqlIrybpvgl gura sylObqlIrybpvgl:Qrfgebl() raq
            vs sylObqlNathyneIrybpvgl gura sylObqlNathyneIrybpvgl:Qrfgebl() raq
            sylObqlIrybpvgl = avy
            sylObqlNathyneIrybpvgl = avy
            abgvsl("❌ Syl", "Havirefny syl qvfnoyrq!", 2)
        raq
    raq
})

-- Abpyvc
ZbirzragGno:PerngrGbttyr({
    Anzr = "👻 Abpyvc",
    PheeragInyhr = snyfr,
    Synt = "abpyvc_gbttyr",
    Pnyyonpx = shapgvba(Inyhr)
        abpyvcRanoyrq = Inyhr
        pyrnahcPbaarpgvba("abpyvc")
        
        vs Inyhr gura
            pbaarpgvbaf["abpyvc"] = EhaFreivpr.Fgrccrq:Pbaarpg(shapgvba()
                ybpny punenpgre = trgPunenpgre(YbpnyCynlre, 1)
                vs punenpgre gura
                    sbe _, cneg va cnvef(punenpgre:TrgQrfpraqnagf()) qb
                        vs cneg:VfN("OnfrCneg") naq cneg.PnaPbyyvqr gura
                            cneg.PnaPbyyvqr = snyfr
                        raq
                    raq
                raq
            raq)
            npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 1
            abgvsl("✅ Abpyvc", "Abpyvc ranoyrq!", 2)
        ryfr
            -- Er-ranoyr pbyyvfvbaf
            ybpny punenpgre = trgPunenpgre(YbpnyCynlre, 1)
            vs punenpgre gura
                sbe _, cneg va cnvef(punenpgre:TrgQrfpraqnagf()) qb
                    vs cneg:VfN("OnfrCneg") naq cneg.Anzr ~= "UhznabvqEbbgCneg" gura
                        cneg.PnaPbyyvqr = gehr
                    raq
                raq
            raq
            abgvsl("❌ Abpyvc", "Abpyvc qvfnoyrq!", 2)
        raq
    raq
})

-- Jnyx fcrrq
ZbirzragGno:PerngrFyvqre({
    Anzr = "Jnyx Fcrrq",
    Enatr = {16, 500},
    Vaperzrag = 1,
    Fhssvk = " fghqf/f",
    PheeragInyhr = 16,
    Synt = "jnyx_fcrrq",
    Pnyyonpx = shapgvba(Inyhr)
        jnyxFcrrq = Inyhr
        ybpny uhznabvq = trgUhznabvq()
        vs uhznabvq gura
            uhznabvq.JnyxFcrrq = Inyhr
        raq
    raq
})

-- Whzc cbjre
ZbirzragGno:PerngrFyvqre({
    Anzr = "Whzc Cbjre",
    Enatr = {50, 500},
    Vaperzrag = 1,
    Fhssvk = " cbjre",
    PheeragInyhr = 50,
    Synt = "whzc_cbjre",
    Pnyyonpx = shapgvba(Inyhr)
        whzcCbjre = Inyhr
        ybpny uhznabvq = trgUhznabvq()
        vs uhznabvq gura
            vs uhznabvq.WhzcCbjre gura
                uhznabvq.WhzcCbjre = Inyhr
            ryfrvs uhznabvq.WhzcUrvtug gura
                uhznabvq.WhzcUrvtug = Inyhr / 4
            raq
        raq
    raq
})

-- Vasvavgr whzc
ZbirzragGno:PerngrGbttyr({
    Anzr = "🦘 Vasvavgr Whzc",
    PheeragInyhr = snyfr,
    Synt = "vasvavgr_whzc",
    Pnyyonpx = shapgvba(Inyhr)
        vasvavgrWhzcRanoyrq = Inyhr
        pyrnahcPbaarpgvba("vasvavgr_whzc")
        
        vs Inyhr gura
            vs abg vfZbovyr gura
                pbaarpgvbaf["vasvavgr_whzc"] = HfreVachgFreivpr.WhzcErdhrfg:Pbaarpg(shapgvba()
                    ybpny uhznabvq = trgUhznabvq()
                    vs uhznabvq gura
                        uhznabvq:PunatrFgngr(Rahz.UhznabvqFgngrGlcr.Whzcvat)
                    raq
                raq)
                npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 1
            ryfr
                -- Zbovyr nygreangvir
                pbaarpgvbaf["vasvavgr_whzc"] = EhaFreivpr.Urnegorng:Pbaarpg(shapgvba()
                    ybpny uhznabvq = trgUhznabvq()
                    vs uhznabvq naq uhznabvq.Whzc gura
                        uhznabvq:PunatrFgngr(Rahz.UhznabvqFgngrGlcr.Whzcvat)
                    raq
                raq)
                npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 1
            raq
            abgvsl("✅ Whzc", "Vasvavgr whzc ranoyrq!", 2)
        ryfr
            abgvsl("❌ Whzc", "Vasvavgr whzc qvfnoyrq!", 2)
        raq
    raq
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         IVFHNY GNO                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

ybpny IvfhnyGno = Jvaqbj:PerngrGno("👁️ Ivfhny", 4335489011)

-- RFC
IvfhnyGno:PerngrGbttyr({
    Anzr = "🌟 Cynlre RFC",
    PheeragInyhr = snyfr,
    Synt = "rfc_gbttyr",
    Pnyyonpx = shapgvba(Inyhr)
        rfcRanoyrq = Inyhr
        
        -- Pyrna hc rkvfgvat RFC
        sbe _, rfcBow va cnvef(rfcBowrpgf) qb
            vs rfcBow naq rfcBow.Cnerag gura
                rfcBow:Qrfgebl()
            raq
        raq
        rfcBowrpgf = {}
        
        vs Inyhr gura
            ybpny shapgvba nqqRFC(cynlre)
                vs cynlre == YbpnyCynlre gura erghea raq
                
                cpnyy(shapgvba()
                    ybpny punenpgre = trgPunenpgre(cynlre, 1)
                    vs abg punenpgre gura erghea raq
                    
                    -- Erzbir byq RFC
                    ybpny byqRFC = punenpgre:SvaqSvefgPuvyq("GhkRFC")
                    vs byqRFC gura byqRFC:Qrfgebl() raq
                    
                    -- Perngr arj RFC
                    ybpny uvtuyvtug = Vafgnapr.arj("Uvtuyvtug")
                    uvtuyvtug.Anzr = "GhkRFC"
                    uvtuyvtug.SvyyPbybe = rfcPbybe
                    uvtuyvtug.BhgyvarPbybe = Pbybe3.arj(1, 1, 1)
                    uvtuyvtug.SvyyGenafcnerapl = 0.5
                    uvtuyvtug.BhgyvarGenafcnerapl = 0
                    uvtuyvtug.Cnerag = punenpgre
                    
                    gnoyr.vafreg(rfcBowrpgf, uvtuyvtug)
                raq)
            raq
            
            -- Nqq RFC gb rkvfgvat cynlref
            sbe _, cynlre va cnvef(Cynlref:TrgCynlref()) qb
                vs cynlre.Punenpgre gura
                    nqqRFC(cynlre)
                raq
            raq
            
            -- Nqq RFC gb arj cynlref
            pbaarpgvbaf["rfc_nqqrq"] = Cynlref.CynlreNqqrq:Pbaarpg(shapgvba(cynlre)
                cynlre.PunenpgreNqqrq:Pbaarpg(shapgvba()
                    jnvg(1)
                    vs rfcRanoyrq gura
                        nqqRFC(cynlre)
                    raq
                raq)
            raq)
            
            -- Hcqngr rkvfgvat cynlref
            pbaarpgvbaf["rfc_fcnja"] = Cynlref.CynlreNqqrq:Pbaarpg(shapgvba(cynlre)
                vs cynlre.Punenpgre gura
                    nqqRFC(cynlre)
                raq
            raq)
            
            npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 2
            abgvsl("✅ RFC", "Cynlre RFC ranoyrq!", 2)
        ryfr
            pyrnahcPbaarpgvba("rfc_nqqrq")
            pyrnahcPbaarpgvba("rfc_fcnja")
            abgvsl("❌ RFC", "Cynlre RFC qvfnoyrq!", 2)
        raq
    raq
})

-- RFC Pbybe cvpxre
IvfhnyGno:PerngrPbybeCvpxre({
    Anzr = "RFC Pbybe",
    Pbybe = Pbybe3.sebzETO(255, 0, 0),
    Synt = "rfc_pbybe",
    Pnyyonpx = shapgvba(Inyhr)
        rfcPbybe = Inyhr
        
        -- Hcqngr rkvfgvat RFC pbybef
        sbe _, rfcBow va cnvef(rfcBowrpgf) qb
            vs rfcBow naq rfcBow.Cnerag gura
                rfcBow.SvyyPbybe = Inyhr
            raq
        raq
    raq
})

-- Shyyoevtug
IvfhnyGno:PerngrGbttyr({
    Anzr = "🔆 Shyyoevtug",
    PheeragInyhr = snyfr,
    Synt = "shyyoevtug_gbttyr",
    Pnyyonpx = shapgvba(Inyhr)
        shyyoevtugRanoyrq = Inyhr
        
        cpnyy(shapgvba()
            vs Inyhr gura
                Yvtugvat.Oevtugarff = 2
                Yvtugvat.PybpxGvzr = 14
                Yvtugvat.SbtRaq = 100000
                Yvtugvat.TybonyFunqbjf = snyfr
                Yvtugvat.BhgqbbeNzovrag = Pbybe3.sebzETO(128, 128, 128)
                abgvsl("✅ Shyyoevtug", "Shyyoevtug ranoyrq!", 2)
            ryfr
                Yvtugvat.Oevtugarff = 1
                Yvtugvat.PybpxGvzr = 12
                Yvtugvat.SbtRaq = 100000
                Yvtugvat.TybonyFunqbjf = gehr
                Yvtugvat.BhgqbbeNzovrag = Pbybe3.sebzETO(70, 70, 70)
                abgvsl("❌ Shyyoevtug", "Shyyoevtug qvfnoyrq!", 2)
            raq
        raq)
    raq
})

-- Grnz purpx
IvfhnyGno:PerngrGbttyr({
    Anzr = "🎯 Grnz Purpx",
    PheeragInyhr = gehr,
    Synt = "grnz_purpx",
    Pnyyonpx = shapgvba(Inyhr)
        grnzPurpxRanoyrq = Inyhr
        abgvsl("🎯 Grnz Purpx", Inyhr naq "Ranoyrq" be "Qvfnoyrq", 2)
    raq
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         PBZONG GNO                                    ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

ybpny PbzongGno = Jvaqbj:PerngrGno("⚔️ Pbzong", 4335454746)

-- Nvzobg SBI
PbzongGno:PerngrFyvqre({
    Anzr = "Nvzobg SBI",
    Enatr = {10, 360},
    Vaperzrag = 1,
    Fhssvk = "°",
    PheeragInyhr = 100,
    Synt = "nvzobg_sbi",
    Pnyyonpx = shapgvba(Inyhr)
        nvzobgSBI = Inyhr
    raq
})

-- Nvzobg
PbzongGno:PerngrGbttyr({
    Anzr = "🎯 Havirefny Nvzobg",
    PheeragInyhr = snyfr,
    Synt = "nvzobg_gbttyr",
    Pnyyonpx = shapgvba(Inyhr)
        nvzobgRanoyrq = Inyhr
        pyrnahcPbaarpgvba("nvzobg")
        
        vs Inyhr gura
            pbaarpgvbaf["nvzobg"] = EhaFreivpr.Urnegorng:Pbaarpg(shapgvba()
                ybpny gnetrg, qvfgnapr = trgPybfrfgCynlre(nvzobgSBI)
                vs gnetrg naq qvfgnapr gura
                    ybpny gnetrgPune = trgPunenpgre(gnetrg, 1)
                    vs gnetrgPune gura
                        ybpny gnetrgUrnq = gnetrgPune:SvaqSvefgPuvyq("Urnq")
                        vs gnetrgUrnq naq Pnzren gura
                            cpnyy(shapgvba()
                                ybpny ybbxQverpgvba = (gnetrgUrnq.Cbfvgvba - Pnzren.PSenzr.Cbfvgvba).Havg
                                Pnzren.PSenzr = PSenzr.ybbxNg(Pnzren.PSenzr.Cbfvgvba, gnetrgUrnq.Cbfvgvba)
                            raq)
                        raq
                    raq
                raq
            raq)
            npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 1
            abgvsl("✅ Nvzobg", "Havirefny nvzobg ranoyrq!", 2)
        ryfr
            abgvsl("❌ Nvzobg", "Havirefny nvzobg qvfnoyrq!", 2)
        raq
    raq
})

-- Nhgb pyvpxre fcrrq
PbzongGno:PerngrFyvqre({
    Anzr = "Nhgb Pyvpx Fcrrq",
    Enatr = {1, 20},
    Vaperzrag = 1,
    Fhssvk = " pcf",
    PheeragInyhr = 10,
    Synt = "pyvpx_fcrrq",
    Pnyyonpx = shapgvba(Inyhr)
        pyvpxFcrrq = Inyhr
    raq
})

-- Nhgb pyvpxre
PbzongGno:PerngrGbttyr({
    Anzr = "🖱️ Nhgb Pyvpxre",
    PheeragInyhr = snyfr,
    Synt = "nhgb_pyvpxre",
    Pnyyonpx = shapgvba(Inyhr)
        nhgbPyvpxreRanoyrq = Inyhr
        pyrnahcPbaarpgvba("nhgb_pyvpxre")
        
        vs Inyhr gura
            pbaarpgvbaf["nhgb_pyvpxre"] = EhaFreivpr.Urnegorng:Pbaarpg(shapgvba()
                vs nhgbPyvpxreRanoyrq gura
                    cresbezPyvpx()
                raq
            raq)
            npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 1
            abgvsl("✅ Nhgb Pyvpx", "Nhgb pyvpxre ranoyrq!", 2)
        ryfr
            abgvsl("❌ Nhgb Pyvpx", "Nhgb pyvpxre qvfnoyrq!", 2)
        raq
    raq
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                      ZVFPRYYNARBHF GNO                                ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

ybpny ZvfpGno = Jvaqbj:PerngrGno("🔧 Zvfp", 4335486884)

-- Nagv NSX
ZvfpGno:PerngrGbttyr({
    Anzr = "😴 Nagv NSX",
    PheeragInyhr = snyfr,
    Synt = "nagv_nsx",
    Pnyyonpx = shapgvba(Inyhr)
        nagvNsxRanoyrq = Inyhr
        pyrnahcPbaarpgvba("nagv_nsx")
        
        vs Inyhr gura
            pbaarpgvbaf["nagv_nsx"] = YbpnyCynlre.Vqyrq:Pbaarpg(shapgvba()
                cpnyy(shapgvba()
                    IveghnyVachgZnantre:FraqXrlRirag(gehr, Rahz.XrlPbqr.YrsgFuvsg, snyfr, tnzr)
                    jnvg(0.1)
                    IveghnyVachgZnantre:FraqXrlRirag(snyfr, Rahz.XrlPbqr.YrsgFuvsg, snyfr, tnzr)
                raq)
            raq)
            npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 1
            abgvsl("✅ Nagv NSX", "Nagv NSX ranoyrq!", 2)
        ryfr
            abgvsl("❌ Nagv NSX", "Nagv NSX qvfnoyrq!", 2)
        raq
    raq
})

-- Pung fcnz zrffntr
ZvfpGno:PerngrVachg({
    Anzr = "Pung Zrffntr",
    CynprubyqreGrkg = "Ragre zrffntr gb fcnz...",
    ErzbirGrkgNsgreSbphfYbfg = snyfr,
    Pnyyonpx = shapgvba(Grkg)
        fcnzZrffntr = Grkg
    raq
})

-- Pung fcnz qrynl
ZvfpGno:PerngrFyvqre({
    Anzr = "Fcnz Qrynl",
    Enatr = {0.5, 10},
    Vaperzrag = 0.1,
    Fhssvk = "f",
    PheeragInyhr = 1,
    Synt = "fcnz_qrynl",
    Pnyyonpx = shapgvba(Inyhr)
        fcnzQrynl = Inyhr
    raq
})

-- Pung fcnz gbttyr
ZvfpGno:PerngrGbttyr({
    Anzr = "💬 Pung Fcnz",
    PheeragInyhr = snyfr,
    Synt = "pung_fcnz",
    Pnyyonpx = shapgvba(Inyhr)
        pungFcnzRanoyrq = Inyhr
        pyrnahcPbaarpgvba("pung_fcnz")
        
        vs Inyhr gura
            pbaarpgvbaf["pung_fcnz"] = gnfx.fcnja(shapgvba()
                juvyr pungFcnzRanoyrq qb
                    cpnyy(shapgvba()
                        -- Gel zhygvcyr pung zrgubqf sbe pbzcngvovyvgl
                        vs ErcyvpngrqFgbentr:SvaqSvefgPuvyq("QrsnhygPungFlfgrzPungRiragf") gura
                            ybpny pungRiragf = ErcyvpngrqFgbentr.QrsnhygPungFlfgrzPungRiragf
                            vs pungRiragf:SvaqSvefgPuvyq("FnlZrffntrErdhrfg") gura
                                pungRiragf.FnlZrffntrErdhrfg:SverFreire(fcnzZrffntr, "Nyy")
                            raq
                        ryfrvs tnzr:TrgFreivpr("GrkgPungFreivpr") gura
                            ybpny grkgPungFreivpr = tnzr:TrgFreivpr("GrkgPungFreivpr")
                            vs grkgPungFreivpr.GrkgPunaaryf naq grkgPungFreivpr.GrkgPunaaryf.EOKTrareny gura
                                grkgPungFreivpr.GrkgPunaaryf.EOKTrareny:FraqNflap(fcnzZrffntr)
                            raq
                        raq
                    raq)
                    jnvg(fcnzQrynl)
                raq
            raq)
            npgvirPbaarpgvbaf = npgvirPbaarpgvbaf + 1
            abgvsl("✅ Pung Fcnz", "Pung fcnz ranoyrq!", 2)
        ryfr
            abgvsl("❌ Pung Fcnz", "Pung fcnz qvfnoyrq!", 2)
        raq
    raq
})

-- Erfrg punenpgre
ZvfpGno:PerngrOhggba({
    Anzr = "💀 Erfrg Punenpgre",
    Pnyyonpx = shapgvba()
        cpnyy(shapgvba()
            ybpny uhznabvq = trgUhznabvq()
            vs uhznabvq gura
                uhznabvq.Urnygu = 0
                abgvsl("💀 Erfrg", "Punenpgre erfrg!", 2)
            raq
        raq)
    raq
})

-- Erfcnja punenpgre
ZvfpGno:PerngrOhggba({
    Anzr = "🔄 Erfcnja",
    Pnyyonpx = shapgvba()
        cpnyy(shapgvba()
            YbpnyCynlre:YbnqPunenpgre()
            abgvsl("🔄 Erfcnja", "Punenpgre erfcnjarq!", 2)
        raq)
    raq
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         FRGGVATF GNO                                  ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

ybpny FrggvatfGno = Jvaqbj:PerngrGno("⚙️ Frggvatf", 4335486884)

FrggvatfGno:PerngrYnory("🎮 Rkrphgbe: " .. rkrphgbe)
FrggvatfGno:PerngrYnory("📱 Cyngsbez: " .. (vfZbovyr naq "Zbovyr" be "CP"))
FrggvatfGno:PerngrYnory("🔧 HV Yvoenel: Enlsvryq")

FrggvatfGno:PerngrOhggba({
    Anzr = "🧹 Pyrnahc Nyy Srngherf",
    Pnyyonpx = shapgvba()
        pyrnahcNyyPbaarpgvbaf()
        
        -- Erfrg punenpgre zbqvsvpngvbaf
        ybpny uhznabvq = trgUhznabvq()
        vs uhznabvq gura
            uhznabvq.JnyxFcrrq = 16
            uhznabvq.WhzcCbjre = 50
        raq
        
        -- Pyrna hc RFC
        sbe _, rfcBow va cnvef(rfcBowrpgf) qb
            vs rfcBow naq rfcBow.Cnerag gura
                rfcBow:Qrfgebl()
            raq
        raq
        rfcBowrpgf = {}
        
        -- Erfrg yvtugvat
        cpnyy(shapgvba()
            Yvtugvat.Oevtugarff = 1
            Yvtugvat.PybpxGvzr = 12
            Yvtugvat.SbtRaq = 100000
            Yvtugvat.TybonyFunqbjf = gehr
            Yvtugvat.BhgqbbeNzovrag = Pbybe3.sebzETO(70, 70, 70)
        raq)
        
        -- Pyrna hc syl bowrpgf
        vs sylObqlIrybpvgl gura sylObqlIrybpvgl:Qrfgebl() raq
        vs sylObqlNathyneIrybpvgl gura sylObqlNathyneIrybpvgl:Qrfgebl() raq
        
        -- Erfrg syntf
        sylRanoyrq = snyfr
        abpyvcRanoyrq = snyfr
        rfcRanoyrq = snyfr
        nvzobgRanoyrq = snyfr
        nhgbPyvpxreRanoyrq = snyfr
        pungFcnzRanoyrq = snyfr
        nagvNsxRanoyrq = snyfr
        vasvavgrWhzcRanoyrq = snyfr
        shyyoevtugRanoyrq = snyfr
        
        abgvsl("🧹 Pyrnahc", "Nyy srngherf pyrnarq hc!", 3)
    raq
})

FrggvatfGno:PerngrOhggba({
    Anzr = "📊 Cresbeznapr Vasb",
    Pnyyonpx = shapgvba()
        ybpny vasb = fgevat.sbezng([[
🎮 Rkrphgbe: %f
📱 Cyngsbez: %f
⚡ Npgvir Srngherf: %q
💾 Zrzbel: %f ZO
📡 Cvat: %f zf
⏱️ Hcgvzr: %qf
        ]], 
        rkrphgbe,
        vfZbovyr naq "Zbovyr" be "CP",
        npgvirPbaarpgvbaf,
        cpnyy(shapgvba() erghea gbfgevat(zngu.sybbe(tnzr:TrgFreivpr("Fgngf"):TrgGbgnyZrzbelHfntrZo())) raq) naq gbfgevat(zngu.sybbe(tnzr:TrgFreivpr("Fgngf"):TrgGbgnyZrzbelHfntrZo())) be "A/N",
        cpnyy(shapgvba() erghea gbfgevat(zngu.sybbe(YbpnyCynlre:TrgArgjbexCvat() * 1000)) raq) naq gbfgevat(zngu.sybbe(YbpnyCynlre:TrgArgjbexCvat() * 1000)) be "A/N",
        zngu.sybbe(gvpx() - fpevcgFgnegGvzr)
        )
        frgPyvcobneq(vasb)
    raq
})

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                         PERQVGF GNO                                   ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

ybpny PerqvgfGno = Jvaqbj:PerngrGno("📜 Perqvgf", 4335489547)

PerqvgfGno:PerngrYnory("🎉 Ghk'f SERR Zrah - Havirefny Rqvgvba")
PerqvgfGno:PerngrYnory("👨‍💻 Perngrq ol: Ghk Fxvqqre")
PerqvgfGno:PerngrYnory("🌟 Irefvba: 3.0.1 - Svkrq & Havirefny")
PerqvgfGno:PerngrYnory("📱 Zbovyr & CP Pbzcngvoyr")
PerqvgfGno:PerngrYnory("🔧 Jbexf ba: Krab, Qrygn, Syhkhf, Neprhf K, rgp.")
PerqvgfGno:PerngrYnory("")
PerqvgfGno:PerngrYnory("🔗 Wbva bhe Qvfpbeq sbe zber fpevcgf!")

PerqvgfGno:PerngrOhggba({
    Anzr = "📋 Pbcl Qvfpbeq Vaivgr",
    Pnyyonpx = shapgvba()
        frgPyvcobneq("uggcf://qvfpbeq.tt/4S7eZDgTur")
    raq
})

PerqvgfGno:PerngrOhggba({
    Anzr = "🌐 Trg Zber Fpevcgf",
    Pnyyonpx = shapgvba()
        frgPyvcobneq("tvguho.pbz/ghkfxvqqre/abin-fpevcgf")
    raq
})

PerqvgfGno:PerngrOhggba({
    Anzr = "⭐ Fhccbeg gur Cebwrpg",
    Pnyyonpx = shapgvba()
        frgPyvcobneq("Gunaxf sbe hfvat Ghk'f SERR Zrah! Cyrnfr fgne bhe ercbfvgbel naq funer jvgu sevraqf!")
    raq
})

PerqvgfGno:PerngrYnory("")
PerqvgfGno:PerngrYnory("🙏 Gunaxf sbe hfvat Ghk'f SERR Zrah!")
PerqvgfGno:PerngrYnory("💝 Guvf fpevcg vf pbzcyrgryl serr naq bcra fbhepr")

-- ╔═══════════════════════════════════════════════════════════════════════╗
-- ║                        VAVGVNYVMNGVBA                                 ║
-- ╚═══════════════════════════════════════════════════════════════════════╝

-- Punenpgre erfcnja unaqyvat
YbpnyCynlre.PunenpgreNqqrq:Pbaarpg(shapgvba(punenpgre)
    jnvg(2) -- Jnvg sbe punenpgre gb shyyl ybnq
    
    -- Ernccyl fcrrq/whzc vs gurl jrer zbqvsvrq
    ybpny uhznabvq = trgUhznabvq()
    vs uhznabvq gura
        vs jnyxFcrrq ~= 16 gura
            uhznabvq.JnyxFcrrq = jnyxFcrrq
        raq
        vs whzcCbjre ~= 50 gura
            vs uhznabvq.WhzcCbjre gura
                uhznabvq.WhzcCbjre = whzcCbjre
            ryfrvs uhznabvq.WhzcUrvtug gura
                uhznabvq.WhzcUrvtug = whzcCbjre / 4
            raq
        raq
    raq
    
    -- Ernccyl RFC vs ranoyrq
    vs rfcRanoyrq gura
        jnvg(1)
        sbe _, cynlre va cnvef(Cynlref:TrgCynlref()) qb
            vs cynlre ~= YbpnyCynlre naq cynlre.Punenpgre gura
                cpnyy(shapgvba()
                    ybpny uvtuyvtug = Vafgnapr.arj("Uvtuyvtug")
                    uvtuyvtug.Anzr = "GhkRFC"
                    uvtuyvtug.SvyyPbybe = rfcPbybe
                    uvtuyvtug.BhgyvarPbybe = Pbybe3.arj(1, 1, 1)
                    uvtuyvtug.SvyyGenafcnerapl = 0.5
                    uvtuyvtug.BhgyvarGenafcnerapl = 0
                    uvtuyvtug.Cnerag = cynlre.Punenpgre
                    gnoyr.vafreg(rfcBowrpgf, uvtuyvtug)
                raq)
            raq
        raq
    raq
raq)

-- Pyrnahc ba yrnivat
tnzr:OvaqGbPybfr(shapgvba()
    pyrnahcNyyPbaarpgvbaf()
raq)

-- Svany abgvsvpngvbaf
abgvsl("🎉 Fhpprff!", "Ghk'f SERR Zrah ybnqrq fhpprffshyyl!", 3)
abgvsl("📱 Cyngsbez", (vfZbovyr naq "Zbovyr zbqr ranoyrq!" be "CP zbqr ranoyrq!"), 2)
abgvsl("🔧 Rkrphgbe", "Ehaavat ba: " .. rkrphgbe, 2)

-- Pbafbyr bhgchg
jnea("✅ Ghk'f SERR Zrah i3.0.1 - Havirefny Rqvgvba ybnqrq!")
jnea("📱 Cyngsbez: " .. (vfZbovyr naq "Zbovyr" be "CP"))
jnea("🔧 Rkrphgbe: " .. rkrphgbe)
jnea("🌟 Nyy srngherf ner abj pbzcngvoyr jvgu lbhe rkrphgbe!")
jnea("📋 Gbgny yvarf: 800+ (Havirefny pbzcngvovyvgl)")

-- Fhpprff zrffntr
cevag([[
╔═══════════════════════════════════════════════════╗
║            GHK'F SERR ZRAH YBNQRQ!               ║
║                                                   ║
║  ✅ Havirefny Pbzcngvovyvgl                      ║
║  📱 Zbovyr & CP Fhccbeg                          ║
║  🔧 Jbexf jvgu nyy znwbe rkrphgbef               ║
║  🎯 Bcgvzvmrq sbe cresbeznapr                    ║
║                                                   ║
║  Rawbl hfvat Ghk'f SERR Zrah!                    ║
╚═══════════════════════════════════════════════════╝
]])
