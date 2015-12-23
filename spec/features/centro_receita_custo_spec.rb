describe "Manipulando Centros de Receita e Custo", type: :feature do

  require "myfinance"

  let(:centers) {
    [
        {"classification_center" => {"cost_center" => true, "created_at" => "2013-05-21T17:05:14-03:00", "entity_id" => 14618, "excel_import_id" => nil, "guid" => nil, "id" => 94150, "imported_from_sync" => false, "modified_by_sync" => false, "name" => "Despesas Marketing", "revenue_center" => false, "updated_at" => "2013-05-21T17:05:14-03:00", "use_count" => 0}},
        {"classification_center" => {"cost_center" => true, "created_at" => "2013-05-21T17:07:04-03:00", "entity_id" => 14618, "excel_import_id" => nil, "guid" => nil, "id" => 94152, "imported_from_sync" => false, "modified_by_sync" => false, "name" => "Despesas Producao TI", "revenue_center" => false, "updated_at" => "2013-05-21T17:07:04-03:00", "use_count" => 2}},
        {"classification_center" => {"cost_center" => false, "created_at" => "2013-07-25T17:06:28-03:00", "entity_id" => 14618, "excel_import_id" => nil, "guid" => nil, "id" => 108858, "imported_from_sync" => false, "modified_by_sync" => false, "name" => "Receita de Marketing", "revenue_center" => true, "updated_at" => "2013-07-25T17:06:28-03:00", "use_count" => 23}},
        {"classification_center" => {"cost_center" => false, "created_at" => "2014-11-05T11:10:42-02:00", "entity_id" => 20341, "excel_import_id" => nil, "guid" => nil, "id" => 173848, "imported_from_sync" => false, "modified_by_sync" => false, "name" => "Receita Total", "revenue_center" => true, "updated_at" => "2014-11-05T11:10:42-02:00", "use_count" => 1}}
    ]
  }

  describe "#centros" do
    it "sem filtro" do
      expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
      centros = Myfinance.centros
      expect(centros.size).to eql(4)
      expect(centros[0]["classification_center"]["id"]).to eql(94150)
      expect(centros[1]["classification_center"]["id"]).to eql(94152)
      expect(centros[2]["classification_center"]["id"]).to eql(108858)
      expect(centros[3]["classification_center"]["id"]).to eql(173848)
    end
    it "somente custo" do
      expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
      centros = Myfinance.centros(true)
      expect(centros.size).to eql(2)
      expect(centros[0]["classification_center"]["id"]).to eql(94150)
      expect(centros[1]["classification_center"]["id"]).to eql(94152)
    end
    it "somente receita" do
      expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
      centros = Myfinance.centros(false)
      expect(centros.size).to eql(2)
      expect(centros[0]["classification_center"]["id"]).to eql(108858)
      expect(centros[1]["classification_center"]["id"]).to eql(173848)
    end
  end

  describe "#centro_id" do
    describe "sem filtro" do
      it "encontrado" do
        expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
        expect(Myfinance.centro_id("Despesas Producao TI")).to eql(94152)
      end
      it "nao encontrado" do
        expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
        expect(Myfinance.centro_id("XYZ")).to be_nil
      end
    end
    describe "somente custo" do
      it "encontrado" do
        expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
        expect(Myfinance.centro_id("Despesas Producao TI", true)).to eql(94152)
      end
      it "nao encontrado" do
        expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
        expect(Myfinance.centro_id("Receita de Marketing", true)).to be_nil
      end
    end
    describe "somente receita" do
      it "encontrado" do
        expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
        expect(Myfinance.centro_id("Despesas Producao TI", false)).to be_nil
      end
      it "nao encontrado" do
        expect(Myfinance).to receive(:classification_centers).once.and_return(centers)
        expect(Myfinance.centro_id("Receita de Marketing", false)).to eql(108858)
      end
    end
  end

  it "#centro_de_receita_id" do
    double id_double = double("id_double")
    expect(Myfinance).to receive(:centro_id).once.with("nome", false).and_return id_double
    expect(Myfinance.centro_de_receita_id("nome")).to eql(id_double)
  end

  it "#centro_de_custo_id" do
    double id_double = double("id_double")
    expect(Myfinance).to receive(:centro_id).once.with("nome", true).and_return id_double
    expect(Myfinance.centro_de_custo_id("nome")).to eql(id_double)
  end

  it "#classification_centers" do
    double classification_center_double = double("classification_center_double")
    expect(Myfinance).to receive(:lget).once.with("/classification_centers.json?page=1").and_return [classification_center_double]
    expect(Myfinance).to receive(:lget).once.with("/classification_centers.json?page=2").and_return []
    expect(Myfinance.classification_centers).to eql([classification_center_double])
  end
end