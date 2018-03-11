describe Finfolio::API::Error do
  it "create a new Error object" do
    error = Finfolio::API::Error.new({"Title" => "Hit A Snag!"}, 500)

    expect(error).to be_a(Finfolio::API::Error)
    expect(error.code).to eq(500)
  end
end
