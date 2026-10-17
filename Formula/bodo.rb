# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1017.4032/bodo-darwin-arm64"
  version "2026.1017.4032"
  sha256 "15c9a5c617c30ef7e13eef09dab16974b3daade34cd752f5fdccb85263ec8e8d"
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
      url "https://cli.bodo-app.com/v/2026.1017.4032/bodo-linux-arm64"
      sha256 "2a3a6b1cf4041be9e8cee55be85bd4f04bff287b3d3bae2568ccd947f2bffa58"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1017.4032/bodo-linux-x64"
      sha256 "8dd34618a9fcc76ac1d4d77c0012bcde21d3079a8e146a4e2fa8c1feaff67bd0"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
