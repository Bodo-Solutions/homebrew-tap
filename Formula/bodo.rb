# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1008.3764/bodo-darwin-arm64"
  version "2026.1008.3764"
  sha256 "50716f4781176156229393383a1aa494c275578ff2fc3900dea5d7f580bd9d52"
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
      url "https://cli.bodo-app.com/v/2026.1008.3764/bodo-linux-arm64"
      sha256 "dedbbe14d8e512052e27d710624afa4583e82491a6b107bd8d795ffbfcae20a4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1008.3764/bodo-linux-x64"
      sha256 "944ab98ddcb210c0ee603f56595aed5b6d53e2eb120c58c451d1ea91d8c09e2a"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
