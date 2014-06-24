require_relative 'caesar'

describe "Encode" do
  it "should encode a single word" do
    expect(caesar_cipher("abc")).to eq("bcd")
  end

  it "should wrap around the alphabet" do
    expect(caesar_cipher("xyz")).to eq("yza")
  end

  it "should encode multi-word plaintext" do
    expect(caesar_cipher("abc xyz")).to eq("bcd yza")
  end

  it "should maintain capitalization" do
    expect(caesar_cipher("aBc")).to eq("bCd")
  end

  it "should accept multi-char shifts" do
    expect(caesar_cipher("abc", 2)).to eq("cde")
  end

  it "should accept negative char shifts" do
    expect(caesar_cipher("ibm",-1)).to eq("hal")
  end
end