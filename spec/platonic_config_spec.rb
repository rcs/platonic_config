require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "PlatonicConfig" do
  describe "basic use" do
    it "can be mixed in" do
      expect {
        Class.new.send(:include, PlatonicConfig)
      }.to_not raise_error
    end
  end
  describe "on the class" do
    before :each do
      @klass = Class.new do
        include PlatonicConfig
      end
    end

    it "exposes the config methods" do
      @klass.respond_to? :color
    end

    it "returns a hash of the options" do
      @klass.options.should == { :color => nil, :size => nil }
    end

    it "exposes the config methods in the instance" do
      @klass.new.respond_to? :color
    end

    it "stores configuration values" do
      @klass.color = "red"
      @klass.color.should == "red"
    end

    it "exposes options in instances" do
      @klass.new.options.should == { :color => nil, :size => nil }
    end

    it "exposes class values in instances" do
      @klass.color = "red"
      @klass.new.color.should == "red"
    end

    it "can be configured with a block" do
      @klass.config do |c|
        c.color = "chartreuse"
      end

      @klass.color.should == "chartreuse"
    end

    describe "for the instance" do
      before :each do
        @instance = @klass.new
      end

      it "allows overriding in instances" do
        @klass.color = "red"
        @instance.color = "blue"
        @instance.color.should == "blue"
      end

      it "merges options in instances" do
        @klass.color = "red"
        @instance.size = "large"
        @instance.options.should == { :color => "red", :size => "large" }
      end

      it "doesn't allow different instances to effect each other" do
        a = @klass.new
        a.color = "brown"
        b = @klass.new
        b.color = "black"
        a.color.should == "brown"
        b.color.should == "black"
      end
      it "can be configured with a block" do
        @instance.config do |c|
          c.size = "middling"
        end
        @instance.size.should == "middling"
      end

    end
  end
end
