# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4092/bodo-darwin-arm64"
  version "2026.1019.4092"
  sha256 "d4dcd97be81a4aa25c1583f88bc1573d820fb3aebb095912bcc29c9ad0e62ae7"
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
      url "https://cli.bodo-app.com/v/2026.1019.4092/bodo-linux-arm64"
      sha256 "1a371a7c9ef5d16777ccaa27a7ba71713f1955bf111eae49cc1c6d0630c6a3d9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4092/bodo-linux-x64"
      sha256 "189de74748996573c484b9f6781e95e10d39747fef7c40dfd52cad7d9e89477f"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
