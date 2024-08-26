export function Logo(props) {
  return (
    <svg viewBox="0 0 129 24" aria-hidden="true" {...props}>
      <g>
        <path
          className="fill-emerald-400"
          d="M16 8a5 5 0 0 0-5-5H5a5 5 0 0 0-5 5v13.927a1 1 0 0 0 1.623.782l3.684-2.93a4 4 0 0 1 2.49-.87H11a5 5 0 0 0 5-5V8Z"
        />
        <text x="25" y="15" dominantBaseline="middle" className="fill-red-400">TechnoBureau</text>
      </g>
    </svg>
  );
}