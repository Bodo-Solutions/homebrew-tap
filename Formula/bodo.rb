# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1005.3617/bodo-darwin-arm64"
  version "2026.1005.3617"
  sha256 "233d392a1be8e7b8213f06107910a2843a74050940b6e7e27a22c68c87e6dece"
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
      url "https://cli.bodo-app.com/v/2026.1005.3617/bodo-linux-arm64"
      sha256 "15dc14fddae445c98e117358dd0cedf93ea9bc940498b576f1e0b8771ca0288f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1005.3617/bodo-linux-x64"
      sha256 "5ee84d0a0e6da3172a19b230e6a65b1554cfda85866f4e8016b50218e68dfc72"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
