# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1118.4750/bodo-darwin-arm64"
  version "2026.1118.4750"
  sha256 "cf47a9c5b34c783bd10aac07f5696e20d78c5f9c900e66e1e719af8ecac51c5a"
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
      url "https://cli.bodo-app.com/v/2026.1118.4750/bodo-linux-arm64"
      sha256 "3cd5815e45de43f516fb110f74a9579ace76e4699ae9abe724f81ca6049788b0"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1118.4750/bodo-linux-x64"
      sha256 "1339358a6b9fac0432aef1de5d5580ef9e0159015ea9baaedfb299776f8c513e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
