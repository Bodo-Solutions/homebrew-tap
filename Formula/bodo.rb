# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1104.4697/bodo-darwin-arm64"
  version "2026.1104.4697"
  sha256 "a48dc8b99f94e83783e1a51caee9807e7be0df9c468563f59d747cb28f925c14"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1104.4697/bodo-linux-arm64"
      sha256 "b095453ed4f3ebdafccaea0c4757c2a4b385d536f7b422b62b0387b499dc14ea"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1104.4697/bodo-linux-x64"
      sha256 "31c7285fa8be6985b024c81b5c799c8adca01d64387434522e5c1749e7ab79ba"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
