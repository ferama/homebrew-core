class CypherShell < Formula
  desc "Command-line shell where you can execute Cypher against Neo4j"
  homepage "https://neo4j.com"
  url "https://dist.neo4j.org/cypher-shell/cypher-shell-5.7.0.zip"
  sha256 "0771508483f27b65d311237158e4d97458df2fe94e1e55e2036f004cdfc9dcc5"
  license "GPL-3.0-only"
  version_scheme 1

  livecheck do
    url "https://neo4j.com/download-center/"
    regex(/href=.*?cypher-shell[._-]v?(\d+(?:\.\d+)+)\.zip/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, all: "11e1c0a0820707930839a53068c73b75f75956266760a853df0f9292f18cac6b"
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    (bin/"cypher-shell").write_env_script libexec/"bin/cypher-shell", Language::Java.overridable_java_home_env
  end

  test do
    # The connection will fail and print the name of the host
    assert_match "doesntexist", shell_output("#{bin}/cypher-shell -a bolt://doesntexist 2>&1", 1)
  end
end
